import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../../config/themes/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final String? hintText;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: hintText ?? S.of(context).searchProducts,
          hintStyle: TextStyle(color: context.mutedTextColor),
          prefixIcon: const Icon(Icons.search, color: AppColors.mutedText),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
