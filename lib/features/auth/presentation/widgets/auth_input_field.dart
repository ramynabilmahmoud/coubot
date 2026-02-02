import 'package:flutter/material.dart';

/// INPUT FIELD
class AuthInputField extends StatelessWidget {
  final String hint;
  final bool obscure;

  /// NEW
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const AuthInputField({
    super.key,
    required this.hint,
    this.obscure = false,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'MadeEvolveSans'),
        filled: true,
        fillColor: const Color(0xFFFFF1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
