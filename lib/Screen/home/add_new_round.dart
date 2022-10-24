import 'package:app/Repository/repository.dart';
import 'package:app/Widget/button_widget.dart';
import 'package:app/Widget/dropdown_button_widget.dart';
import 'package:app/model/round.dart';
import 'package:app/streams/nearby_course_stream.dart';
import 'package:flutter/material.dart';

import 'add_new_hole.dart';
import 'components/dropdown_date_picker.dart';
import 'package:http/http.dart' as http;

class AddNewRound extends StatefulWidget {
  const AddNewRound({super.key});

  @override
  State<AddNewRound> createState() => _AddNewRoundState();
}

class _AddNewRoundState extends State<AddNewRound> {
  DateTime? datel = DateTime.now();
  NearbyStream? nearbyStream =
      NearbyStream(Repository(httpClient: http.Client()));
  String course = '';
  String no_holes = '9';
  String date = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nearbyStream!.getNearbyCourse();
  }

  Widget _buildSelectCourse() {
    return StreamBuilder<List<String>>(
      // initialData: getBalanceBloc.pointBalance,
      stream: nearbyStream?.responseData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          course = snapshot.data![0];
          return DropDownButtonWidget(
            list: snapshot.data!.length != 0 ? snapshot.data : ["Location 1"],
            label: 'Select the course',
            valueChanged: (String value) {
              course = value;
            },
          );
        }
        if (snapshot.hasError) {
          print("Error ${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = ["9", "18"];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  "Round",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "New",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          )),
      backgroundColor: Colors.grey.shade900,
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const DropDownDatePicker(
                        label: 'Date of the round',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildSelectCourse(),
                      const SizedBox(
                        height: 20,
                      ),
                      DropDownButtonWidget(
                        list: list,
                        label: 'Number of holes',
                        valueChanged: (String value) {
                          no_holes = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
                onPressed: () {
                  Round round = Round(
                      field_name: course,
                      date: "Sept 14",
                      number_of_holes: int.parse(no_holes));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AddNewHole(
                            fromRound: false,
                            round: round,
                          )));
                },
                text: 'Add holes')
          ],
        ),
      ),
    );
  }
}
