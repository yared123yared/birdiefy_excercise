import 'package:app/Screen/round/components/stats_widget.dart';
import 'package:app/Screen/round/round_detail/components/scroreboard_page.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'components/score_page.dart';

class RoundDetailPage extends StatelessWidget {
  final Round round;
  final int totalHits;
  final int expectedHits;
  const RoundDetailPage(
      {super.key,
      required this.round,
      required this.totalHits,
      required this.expectedHits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                "${round.field_name}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${round.date}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    StatsWidget(),
                  ],
                ),
                ScoreBoardPage(
                    round: round,
                    expectedHits: expectedHits,
                    totalHits: totalHits),
                ScorePage(
                  round: round,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
