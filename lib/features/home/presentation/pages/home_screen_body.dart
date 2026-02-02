import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/core/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/product.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import '../widgets/category_shortcuts.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/product_card_large.dart';
import '../widgets/product_horizontal_list.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),

          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial) {
                  context.read<HomeCubit>().load();
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is HomeLoading) {
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

                // 👇 المنتجات اللي هتتعرض
                final displayProducts = loaded.searchQuery.isNotEmpty
                    ? cubit.getFilteredProducts(feed)
                    : feed.buyAgain;

                return RefreshIndicator(
                  onRefresh: () => context.read<HomeCubit>().load(),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    children: [
                      // ✅ SearchBarWidget اتشالت

                      // Top items section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionHeader(
                          title: "Top items",
                          onSeeAll: () {},
                        ),
                      ),
                      const SizedBox(height: 10),

                      ProductHorizontalList(
                        products: feed.topItems,
                        onTap: (product) => _openProductDetails(
                          context,
                          product,
                          loaded,
                          cubit,
                        ),
                        isFavoriteChecker: (productId) =>
                            loaded.favorites.contains(productId),
                        onFavoriteTap: (product) =>
                            cubit.toggleFavorite(product),
                      ),

                      const SizedBox(height: 14),

                      // Category shortcuts
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CategoryShortcuts(
                          categories: feed.categories,
                          onTap: (category) {
                            cubit.filterByCategory(
                              loaded.selectedCategoryId == category.id
                                  ? null
                                  : category,
                            );
                          },
                          selectedCategoryId: loaded.selectedCategoryId,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Buy again section (or search results)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionHeader(
                          title: loaded.searchQuery.isNotEmpty
                              ? "Search Results"
                              : "Buy again",
                          onSeeAll: () {},
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Grid OR Empty State
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final itemWidth = (width - 12) / 2;

                            if (displayProducts.isEmpty) {
                              final isSearching =
                                  loaded.searchQuery.isNotEmpty;

                              if (isSearching) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: Center(
                                    child: Text("No products found"),
                                  ),
                                );
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 28),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "No items to buy again",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.mutedText,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      SizedBox(
                                        width: 220,
                                        child: CustomButton(
                                          title: "Make an order",
                                          icon: Icons.shopping_bag_outlined,
                                          height: 52,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Start a new order"),
                                              ),
                                            );
                                            // context.router.push(const CreateOrderRoute());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: displayProducts.map((p) {
                                return SizedBox(
                                  width: itemWidth,
                                  child: ProductCardLarge(
                                    product: p,
                                    isFavorite:
                                        loaded.favorites.contains(p.id),
                                    onFavoriteTap: () =>
                                        cubit.toggleFavorite(p),
                                    onTap: () => _openProductDetails(
                                      context,
                                      p,
                                      loaded,
                                      cubit,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openProductDetails(
    BuildContext context,
    Product product,
    HomeLoaded state,
    HomeCubit cubit,
  ) {
    context.router.push(
      ProductsDetailsRoute(
        product: product,
        isFavorite: state.favorites.contains(product.id),
        isInCart: state.cartItems.contains(product.id),
        onToggleFavorite: () => cubit.toggleFavorite(product),
        onAddToCart: () => cubit.addToCart(product),
      ),
    );
  }
}
