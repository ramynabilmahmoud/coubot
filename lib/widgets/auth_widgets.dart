import 'package:flutter/material.dart';

/// INPUT FIELD
class AuthInputField extends StatelessWidget {
  final String hint;
  final bool obscure;

  const AuthInputField({
    super.key,
    required this.hint,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'MadeEvolveSans',
        ),
        filled: true,
        fillColor: const Color(0xFFFFF1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}

/// MAIN BUTTON
class AuthMainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AuthMainButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
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