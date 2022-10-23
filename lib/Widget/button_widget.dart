import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ButtonWidget({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) {
          return const EdgeInsets.symmetric(horizontal: 50, vertical: 12);
        }),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          );
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return green, otherwise blue
          if (states.contains(MaterialState.pressed)) {
            return AppTheme.buttonPressedColor;
          }
          return AppTheme.primaryColor;
        }),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
