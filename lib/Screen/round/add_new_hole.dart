import 'package:app/Screen/round/round_list_page.dart';
import 'package:app/Widget/button_widget.dart';
import 'package:app/model/holes.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  List hits = [for (var i = 1; i < 100; i += 1) i];

  int hitsSelected = 0;
  int parsSelected = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hitsSelected = hits.first;
    parsSelected = list.first;
  }

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
            children: [
              AutoSizeText(
                "${widget.round!.field_name}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
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
                    const Text(
                      "Types of hole",
                      style:
                          TextStyle(color: AppTheme.primaryColor, fontSize: 20),
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
                    const Text(
                      "Hits",
                      style:
                          TextStyle(color: AppTheme.primaryColor, fontSize: 20),
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
                          Holes holes =
                              Holes(hits: hitsSelected, pars: parsSelected);
                          print("HOles before assignment: ${holes}");
                          round?.holes?.add(
                              Holes(hits: hitsSelected, pars: parsSelected));

                          if (round!.holes == null ||
                              round.holes!.length <
                                  round.number_of_holes!.toInt() + 1) {
                            if (widget.fromRound) {
                              await addHolesToRound(
                                  round: round,
                                  holes: Holes(
                                      hits: hitsSelected, pars: parsSelected));
                            } else {
                              print("Round holes: ${round!.holes}");
                              await createNewRound(round: round, holes: holes);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Your Hole is filled with the desired hole number"),
                              ),
                            );
                          }

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const RoundListPage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Save",
                            style: TextStyle(color: AppTheme.primaryColor),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            color: AppTheme.primaryColor,
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
                onPressed: () async {
                  // if (widget.round!.holes!.length ==
                  //     widget.round!.number_of_holes) {

                  // } else {
                  //   // the round is not ready to finish
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(
                  //           "This is not ready for finish ${widget.round!.holes!.length}"),
                  //     ),
                  //   );
                  // }
                  await finishRound(round: widget.round);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RoundListPage()));
                },
                text: 'Finish Round'),
          ],
        ),
      ),
    );
  }
}
