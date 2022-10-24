import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class NoRoundWidget extends StatelessWidget {
  const NoRoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "There is no round added yet",
        style: TextStyle(color: AppTheme.primaryColor),
      ),
    );
  }
}
