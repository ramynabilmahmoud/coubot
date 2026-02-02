import 'package:flutter/material.dart';

/// MAIN BUTTON
class AuthMainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AuthMainButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC72C41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'MadeEvolveSansEvo',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
