import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';

class PriceRatingRow extends StatelessWidget {
  final double price;
  final double rating;

  const PriceRatingRow({super.key, required this.price, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${price.toStringAsFixed(0)} LE",
            style: const TextStyle(fontWeight: FontWeight.w800)),
        const Spacer(),
        const Icon(Icons.star, size: 16, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1),
            style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
