import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(
            Icons.query_stats,
            color: AppTheme.primaryColor,
          ),
          SizedBox(
            width: 3,
          ),
          Text("stats", style: TextStyle(color: AppTheme.primaryColor))
        ],
      ),
    );
  }
}
