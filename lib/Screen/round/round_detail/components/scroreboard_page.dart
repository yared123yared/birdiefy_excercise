import 'package:app/Screen/round/round_detail/components/scoreboard_widget.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ScoreBoardPage extends StatelessWidget {
  final Round round;
  final int totalHits;
  final int expectedHits;
  const ScoreBoardPage(
      {super.key,
      required this.round,
      required this.expectedHits,
      required this.totalHits});

  @override
  Widget build(BuildContext context) {
    List<int> holes_1 = [for (var i = 1; i <= 9; i += 1) i];
    List<int> holes_2 = [for (var i = 10; i <= 18; i += 1) i];
    int totalScore = totalHits - expectedHits;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          // height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Scorecard",
                    style:
                        TextStyle(color: AppTheme.primaryColor, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  // height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScoreBoardWidget(
                        holes: holes_1,
                        round: round,
                        from_18: false,
                      ),
                      round.number_of_holes == 18
                          ? ScoreBoardWidget(
                              holes: holes_2,
                              round: round,
                              from_18: true,
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${totalHits}(${totalScore < 0 ? totalScore : '+$totalScore'})',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
