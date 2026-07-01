import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';
import 'product_card_small.dart';

class ProductHorizontalList extends StatelessWidget {
  final List<ProductEntity> products;
  final ValueChanged<ProductEntity>? onTap;
  final bool Function(String)? isFavoriteChecker;
  final ValueChanged<ProductEntity>? onFavoriteTap;

  const ProductHorizontalList({
    super.key,
    required this.products,
    this.onTap,
    this.isFavoriteChecker,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        padding: const EdgeInsets.only(right: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => Padding(
          padding: EdgeInsets.only(left: i == 0 ? 16 : 0),
          child: RepaintBoundary(
            child: ProductCardSmall(
              product: products[i],
              onTap: () => onTap?.call(products[i]),
              isFavorite: isFavoriteChecker?.call(products[i].id) ?? false,
              onFavoriteTap: () => onFavoriteTap?.call(products[i]),
            ),
          ),
        ),
      ),
    );
  }
}
