import 'package:app/Screen/round/round_detail/components/scoreboard_title.dart';
import 'package:app/model/holes.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ScoreBoardWidget extends StatelessWidget {
  final Round round;
  final List<int> holes;
  const ScoreBoardWidget({super.key, required this.round, required this.holes});
  int getTotalHits() {
    if (round.holes == null) return 0;
    int sum = 0;
    for (int i = 0; i < round.holes!.length; i += 1) {
      sum += round.holes![i].hits;
    }
    return sum;
  }

  int getExpectedHits() {
    if (round.holes == null) return 0;
    int sum = 0;
    for (int i = 0; i < round.holes!.length; i += 1) {
      sum += round.holes![i].pars;
    }
    return sum;
  }

  _buildSpacer(double height) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widget = [];

    widget.add(const ScoreBoardTtile());

    widget.add(_buildSpacer(20));

    for (int i in holes) {
      Widget hits = const Text('');
      String pars = '';
      if (i <= round.holes!.length) {
        Holes hole = round.holes![i - 1];
        hits = Text(
          hole.hits.toString(),
          style: TextStyle(
              color: hole.hits <= hole.pars
                  ? AppTheme.primaryColor
                  : hole.hits == hole.pars + 1
                      ? Colors.redAccent.shade100
                      : Colors.red),
        );
        hole.hits.toString();
        pars = hole.pars.toString();
      }

      widget.add(Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$i',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              pars,
              style: const TextStyle(color: Colors.white),
            ),
            hits
          ],
        ),
      ));
    }
    widget.add(_buildSpacer(5));

    widget.add(Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            '    ',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '${getExpectedHits()}',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            '${getTotalHits()}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ));

  

    return Expanded(
      // height: 200,
      child: Column(
        children: widget,
      ),
    );
  }
}
