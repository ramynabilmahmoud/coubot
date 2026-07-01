import 'package:flutter/material.dart';

/// MAIN BUTTON
class AuthMainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double fontSize;
  final double width;
  final double height;
  final FontWeight fontWeight;

  const AuthMainButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.fontSize = 20,
    this.width = 220,
    this.height = 56,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC72C41),
          disabledBackgroundColor: const Color(0xFFC72C41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontFamily: 'MadeEvolveSansEvo',
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
