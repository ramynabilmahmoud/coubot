import 'package:coubot/features/app_splash/presentation/cubit/main/main_cubit.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/product_entity.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/product_card_large.dart';
import '../widgets/product_horizontal_list.dart';
import 'product_details_screen.dart';
import 'package:coubot/ai/widgets/recommendation_banner.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          const RecommendationBanner(),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial || state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is HomeError) {
                  return Center(child: Text(state.message));
                }

                final loaded = state as HomeLoaded;
                final feed = loaded.feed;
                final cubit = context.read<HomeCubit>();
                final isSearching = loaded.searchQuery.isNotEmpty;

                return RefreshIndicator(
                  onRefresh: () => context.read<HomeCubit>().load(),
                  child: isSearching
                      ? _SearchResultsBody(
                          products: cubit.getFilteredProducts(feed),
                          loaded: loaded,
                          cubit: cubit,
                          context: context,
                        )
                      : _CategoryFeedBody(
                          grouped: cubit.getProductsGroupedByCategory(feed),
                          loaded: loaded,
                          cubit: cubit,
                          context: context,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category feed: one horizontal row per category ──────────────────────────

class _CategoryFeedBody extends StatelessWidget {
  final Map grouped;
  final HomeLoaded loaded;
  final HomeCubit cubit;
  final BuildContext context;

  const _CategoryFeedBody({
    required this.grouped,
    required this.loaded,
    required this.cubit,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    if (grouped.isEmpty) {
      return Center(
        child: Text(
          S.of(ctx).noItemsAvailable,
          style: TextStyle(
            color: ctx.mutedTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final entries = grouped.entries.toList();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 12, bottom: 32),
      itemCount: entries.length,
      itemBuilder: (_, i) {
        final category = entries[i].key;
        final products = entries[i].value as List<ProductEntity>;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SectionHeader(
                title: category.localizedTitle(
                  context.read<MainCubit>().currentLangCode,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ProductHorizontalList(
              products: products,
              onTap: (p) => _open(ctx, p),
              isFavoriteChecker: (id) => loaded.favorites.contains(id),
              onFavoriteTap: (p) => cubit.toggleFavorite(p),
            ),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }

  void _open(BuildContext ctx, ProductEntity product) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ProductsDetailsScreen(
            product: product,
            isFavorite: loaded.favorites.contains(product.id),
            onToggleFavorite: () => cubit.toggleFavorite(product),
          ),
        ),
      ),
    );
  }
}

// ── Search results: 2-column grid ───────────────────────────────────────────

class _SearchResultsBody extends StatelessWidget {
  final List<ProductEntity> products;
  final HomeLoaded loaded;
  final HomeCubit cubit;
  final BuildContext context;

  const _SearchResultsBody({
    required this.products,
    required this.loaded,
    required this.cubit,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          S.of(ctx).noProductsFound,
          style: TextStyle(
            color: ctx.mutedTextColor,
            fontWeight: FontWeight.w600,
          ),
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
      itemCount: products.length,
      itemBuilder: (_, i) {
        final p = products[i];
        return ProductCardLarge(
          product: p,
          isFavorite: loaded.favorites.contains(p.id),
          onFavoriteTap: () => cubit.toggleFavorite(p),
          onTap: () => _open(ctx, p),
        );
      },
    );
  }

  void _open(BuildContext ctx, ProductEntity product) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ProductsDetailsScreen(
            product: product,
            isFavorite: loaded.favorites.contains(product.id),
            onToggleFavorite: () => cubit.toggleFavorite(product),
          ),
        ),
      ),
    );
  }
}
