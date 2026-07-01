import 'package:coubot/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

/// ----------------------------
/// Summary Row Widget
/// ----------------------------
class CartSummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const CartSummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppColors.text : AppColors.mutedText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w700,
            color: isTotal ? AppColors.primary : AppColors.text,
          ),
        ),
      ],
    );
  }
}
