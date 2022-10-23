import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SelectorWidget extends StatefulWidget {
  final bool fromhits;
  final List list;
  const SelectorWidget({super.key, required this.list, required this.fromhits});

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade900,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () => buttonCarouselController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear),
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.lightGreenAccent.shade400,
                  )),
            ),
            VerticalDivider(
                width: 20,
                thickness: !widget.fromhits ? 0.3 : 1,
                // indent: 2,
                endIndent: 0,
                color: Colors.white),
            Expanded(
              child: Container(
                // width: 350,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                      enableInfiniteScroll: false,
                      padEnds: true),
                  items: widget.list.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return FittedBox(
                          child: Container(

                              // width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              // decoration: BoxDecoration(color: Colors.amber),
                              child: Text(
                                '$i',
                                style: TextStyle(
                                    fontSize: 4.0,
                                    color: Colors.lightGreenAccent.shade400),
                              )),
                        );
                      },
                    );
                  }).toList(),
                  carouselController: buttonCarouselController,
                ),
              ),
            ),
            VerticalDivider(
              // width: 20,
              thickness: widget.fromhits ? 0.3 : 1,
              // indent: 10,
              endIndent: 0,
              color: Colors.white,
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () => buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.lightGreenAccent.shade400,
                  )),
            )
            // Text(_selector())
          ],
        ),
      ),
    );
  }
}
