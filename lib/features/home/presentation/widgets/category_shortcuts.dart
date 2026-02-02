import 'package:flutter/material.dart';
import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/category.dart';

class CategoryShortcuts extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<Category>? onTap;
  final String? selectedCategoryId;

  const CategoryShortcuts({
    super.key,
    required this.categories,
    this.onTap,
    this.selectedCategoryId,
  });

  IconData _icon(String key) {
    return switch (key) {
      "food" => Icons.lunch_dining,
      "drinks" => Icons.local_drink,
      "dessert" => Icons.icecream,
      _ => Icons.grid_view_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categories.map((c) {
        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => onTap?.call(c),
            child: Column(
              children: [
                Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: selectedCategoryId == c.id ? AppColors.primary : AppColors.chipBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selectedCategoryId == c.id ? AppColors.primary : Colors.black12,
                    ),
                  ),
                  child: Icon(
                    _icon(c.iconKey),
                    color: selectedCategoryId == c.id ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  c.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: selectedCategoryId == c.id ? AppColors.primary : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
