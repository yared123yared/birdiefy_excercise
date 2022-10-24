import 'package:app/Screen/round/round_detail/components/scoreboard_title.dart';
import 'package:app/model/holes.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ScoreBoardWidget extends StatelessWidget {
  final bool from_18;
  final Round round;
  final List<int> holes;
  const ScoreBoardWidget(
      {super.key,
      required this.round,
      required this.holes,
      required this.from_18});
  int getTotalHits() {
    int index = from_18 ? 10 : 0;

    if (round.holes == null) return 0;
    if (round.holes!.length < index) return 0;
    int sum = 0;
    int limit = round.holes!.length < 9 ? round.holes!.length : 9;
    late List<Holes> list;
    if (from_18) {
      list = round.holes!.sublist(9, round.holes!.length);
    }
    List<Holes> list2 = round.holes!.sublist(0, limit);

    var listForuse = from_18 == true ? list : list2;
    for (int i = 0; i < listForuse.length; i += 1) {
      sum += listForuse[i].hits;
    }
    return sum;
  }

  int getExpectedHits() {
    int index = from_18 ? 10 : 0;

    if (round.holes == null) return 0;
    if (round.holes!.length < index) return 0;
    int sum = 0;
    int limit = round.holes!.length < 9 ? round.holes!.length : 9;
    List<Holes> list =
        from_18 == true ? round.holes!.sublist(0, round.holes!.length) : [];
    List<Holes> list2 = round.holes!.sublist(0, limit);

    var listForuse = from_18 == true ? list : list2;
    for (int i = 0; i < listForuse.length; i += 1) {
      sum += listForuse[i].pars;
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
