import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/features/home/domain/entities/product_entity.dart';
import 'package:coubot/features/home/presentation/cubits/home_cubit.dart';
import 'package:coubot/features/home/presentation/cubits/home_state.dart';
import 'package:coubot/features/home/presentation/pages/product_details_screen.dart';
import 'package:coubot/features/home/presentation/widgets/product_card_large.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).favourites,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            );
          }

          final loaded = state as HomeLoaded;
          final cubit = context.read<HomeCubit>();

          final favourites = loaded.feed.topItems
              .where((p) => loaded.favorites.contains(p.id))
              .toList();

          if (favourites.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 72,
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).noFavouritesYet,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    S.of(context).tapHeartToSaveFavourites,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: favourites.length,
            itemBuilder: (_, i) {
              final product = favourites[i];
              return RepaintBoundary(
                child: ProductCardLarge(
                  product: product,
                  isFavorite: true,
                  onFavoriteTap: () => cubit.toggleFavorite(product),
                  onTap: () => _openDetails(context, product, loaded, cubit),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openDetails(
    BuildContext context,
    ProductEntity product,
    HomeLoaded state,
    HomeCubit cubit,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ProductsDetailsScreen(
            product: product,
            isFavorite: state.favorites.contains(product.id),
            onToggleFavorite: () => cubit.toggleFavorite(product),
          ),
        ),
      ),
    );
  }
}
