import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coubot/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/price_rating_row.dart';
import '../../domain/entities/product_entity.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';

@RoutePage()
class ProductsDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const ProductsDetailsScreen({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = ValueNotifier<int>(1);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator.adaptive()),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported_outlined, size: 40),
                      ),
                    ),
                  ),
                  if (product.onSale)
                    Positioned(
                      top: 50,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          S.of(context).onSale,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ValueListenableBuilder<int>(
                valueListenable: quantity,
                builder: (context, q, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.description,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, homeState) {
                              final liveFav = homeState is HomeLoaded
                                  ? homeState.favorites.contains(product.id)
                                  : isFavorite;
                              return IconButton(
                                onPressed: onToggleFavorite,
                                icon: Icon(
                                  liveFav ? Icons.favorite : Icons.favorite_border,
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      PriceRatingRow(price: product.price, rating: product.rating),

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).quantity,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: q > 1 ? () => quantity.value = q - 1 : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: AppColors.primary,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Text(
                                    '$q',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => quantity.value = q + 1,
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            final qty = quantity.value;
                            await context.read<CartCubit>().add(
                              productId: product.id,
                              title: product.name,
                              subtitle: product.description,
                              price: product.price,
                              imageUrl: product.imageUrl,
                              qty: qty,
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} added to cart (x$qty)'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                          child: Text(
                            S.of(context).addToCart,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
