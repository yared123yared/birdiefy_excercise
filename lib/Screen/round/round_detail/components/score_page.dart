import 'package:app/model/holes.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final Round round;
  const ScorePage({super.key, required this.round});

  countBirdies() {
    int birdy = 0;
    int pars = 0;
    int boggy = 0;
    if (round.holes == null) return 0;
    for (Holes hole in round.holes!) {
      if (hole.hits - hole.pars <= -1) {
        birdy += 1;
      } else if (hole.hits - hole.pars == 0) {
        pars += 1;
      } else if (hole.hits - hole.pars >= 1) {
        boggy += 1;
      }
    }
    List<int> score = [birdy, pars, boggy];
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Scoring",
                style: TextStyle(color: AppTheme.primaryColor, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Birdies",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "${countBirdies()[0]}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pars",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "${countBirdies()[1]}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Boggeys",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "${countBirdies()[2]}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
