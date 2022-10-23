import 'dart:io';

import 'package:app/Widget/button_widget.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ObjectDetector extends StatefulWidget {
  @override
  _ObjectDetectorState createState() => _ObjectDetectorState();
}

class _ObjectDetectorState extends State<ObjectDetector> {
  File? _image;

  double? _imageWidth;
  double? _imageHeight;
  bool _busy = false;

  List? _recognitions;

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: "assets/tflite/ssd_mobilenet.tflite",
        labels: "assets/tflite/ssd_mobilenet.txt",
      );
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  selectFromImagePicker() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(File(image.path));
  }

  predictImage(File image) async {
    if (image == null) return;
    await ssdMobileNet(image);

    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  ssdMobileNet(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight! / _imageHeight! * screen.width;

    Color blue = Colors.red;

    return _recognitions!.map((re) {
      return Positioned(
          left: re["rect"]["x"] * factorX,
          top: re["rect"]["y"] * factorY,
          width: re["rect"]["w"] * factorX,
          height: re["rect"]["h"] * factorY,
          child: ((re["confidenceInClass"] > 0.50))
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: blue,
                    width: 3,
                  )),
                  child: Text(
                    "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      background: Paint()..color = blue,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                )
              : Container());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null ? Text("No Image Selected") : Image.file(_image!),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.topRight, child: Text("Detect Objects\nNew")),
        backgroundColor: AppTheme.primaryColor,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
              onPressed: selectFromImagePicker, text: "Select Image"),
        ),
      ),
      body: Stack(
        children: stackChildren,
      ),
    );
  }
}
