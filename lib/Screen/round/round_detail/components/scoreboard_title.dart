import 'package:flutter/material.dart';

class ScoreBoardTtile extends StatelessWidget {
  const ScoreBoardTtile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            'Hole',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'Par',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'Hits',
            style: TextStyle(color: Colors.white),
          ),
        ]);
  }
}
