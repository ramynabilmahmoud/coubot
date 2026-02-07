import 'package:coubot/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CartItemCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int quantity;

  final String? imageUrl;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onRemove;

  const CartItemCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.onPlus,
    required this.onMinus,
    required this.onRemove,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          /// Image / Placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.chipBg,
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: (imageUrl != null && imageUrl!.trim().isNotEmpty)
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.fastfood,
                    color: AppColors.primary,
                    size: 28,
                  ),
          ),

          const SizedBox(width: 12),

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: AppColors.text,
                        ),
                      ),
                    ),

                    /// Remove Button
                    IconButton(
                      onPressed: onRemove,
                      icon: const Icon(Icons.close),
                      iconSize: 18,
                      color: AppColors.mutedText,
                      splashRadius: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${price.toStringAsFixed(0)} EGP",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          /// Quantity Buttons
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  onPressed: onPlus,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "$quantity",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.chipBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove, color: AppColors.primary, size: 18),
                  onPressed: onMinus,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
