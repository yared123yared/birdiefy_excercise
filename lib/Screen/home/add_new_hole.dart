import 'package:app/Screen/home/home.dart';
import 'package:app/Widget/button_widget.dart';
import 'package:app/model/holes.dart';
import 'package:app/model/round.dart';
import 'package:flutter/material.dart';

import 'components/selector_widget.dart';
import 'package:app/service/firebase_service.dart';

class AddNewHole extends StatefulWidget {
  final bool fromRound;
  Round? round;
  AddNewHole({super.key, required this.fromRound, this.round});

  @override
  State<AddNewHole> createState() => _AddNewHoleState();
}

class _AddNewHoleState extends State<AddNewHole> {
  List list = [3, 4, 5];
  List hits = [for (var i = 0; i < 10; i += 1) i];

  int hitsSelected = 0;
  int parsSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "Golf Field 2",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Hole #5",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 3, 10, 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Types of hole",
                      style: TextStyle(
                          color: Colors.lightGreenAccent.shade400,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SelectorWidget(
                      list: list,
                      fromhits: false,
                      valueChanged: (int value) {
                        parsSelected = value;
                        print("Current pars value $value");
                      },
                      isPars: true,
                      // buttonCarouselController: parsController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hits",
                      style: TextStyle(
                          color: Colors.lightGreenAccent.shade400,
                          fontSize: 20),
                    ),
                    SelectorWidget(
                      list: hits,
                      fromhits: true,
                      valueChanged: (int value) {
                        print("Current hits: $value");
                        hitsSelected = value;
                      },
                      isPars: false,
                      // buttonCarouselController: hitsController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("Pars and hits: $parsSelected");
                        print("Pars and hits: $hitsSelected");
                        try {
                          Round? round = widget.round;
                          round?.holes?.add(
                              Holes(hits: hitsSelected, pars: parsSelected));

                          if (widget.fromRound) {
                            await addHolesToRound(round: round, holes: Holes(hits: hitsSelected, pars: parsSelected));
                    
                          } else {
                                    await createNewRound(round: round);
                          }

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.lightGreenAccent.shade400),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.lightGreenAccent.shade400,
                            size: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                text: 'Finish Round'),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     padding: MaterialStateProperty.resolveWith((states) {
            //       return const EdgeInsets.symmetric(horizontal: 50, vertical: 12);
            //     }),
            //     shape: MaterialStateProperty.resolveWith((states) {
            //       return RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(18),
            //       );
            //     }),
            //     backgroundColor: MaterialStateProperty.resolveWith((states) {
            //       // If the button is pressed, return green, otherwise blue
            //       if (states.contains(MaterialState.pressed)) {
            //         return Colors.lightGreenAccent;
            //       }
            //       return Colors.lightGreenAccent.shade400;
            //     }),
            //   ),
            //   onPressed: () async {
            //     Navigator.of(context).pushReplacement(MaterialPageRoute(
            //         builder: (context) => const AddNewHole()));
            //   },
            //   child: const Text(
            //     'Finish Round',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
