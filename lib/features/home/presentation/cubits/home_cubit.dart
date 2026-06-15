import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_feed.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeFeed getHomeFeed;
  final HomeRepository _repo;

  HomeCubit(this.getHomeFeed, this._repo) : super(HomeInitial());

  Future<void> load() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        getHomeFeed(),
        _repo.getFavourites(),
      ]);
      emit(HomeLoaded(
        feed: results[0] as HomeFeed,
        favorites: results[1] as List<String>,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Search products by name/description
  void search(String query) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    emit(state.copyWith(searchQuery: query));
  }

  /// Filter by category
  void filterByCategory(CategoryEntity? category) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    emit(state.copyWith(selectedCategoryId: category?.id));
  }

  /// Add product to cart
  void addToCart(ProductEntity product) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    final updatedCart = [...state.cartItems];
    if (!updatedCart.contains(product.id)) {
      updatedCart.add(product.id);
    }
    emit(state.copyWith(cartItems: updatedCart));
  }

  /// Remove product from cart
  void removeFromCart(String productId) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    final updatedCart = state.cartItems.where((id) => id != productId).toList();
    emit(state.copyWith(cartItems: updatedCart));
  }

  /// Toggle favorite — optimistic UI then persist to Supabase
  void toggleFavorite(ProductEntity product) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    final updatedFavorites = [...state.favorites];
    if (updatedFavorites.contains(product.id)) {
      updatedFavorites.removeWhere((id) => id == product.id);
    } else {
      updatedFavorites.add(product.id);
    }

    // Optimistic update
    emit(state.copyWith(favorites: updatedFavorites));

    // Persist asynchronously — revert on failure
    _repo.updateFavourites(updatedFavorites).catchError((_) {
      if (this.state is HomeLoaded) {
        emit((this.state as HomeLoaded).copyWith(favorites: state.favorites));
      }
    });
  }

  /// Products grouped by category — used for home feed sections
  Map<CategoryEntity, List<ProductEntity>> getProductsGroupedByCategory(HomeFeed feed) {
    final result = <CategoryEntity, List<ProductEntity>>{};
    for (final category in feed.categories) {
      final products = feed.topItems.where((p) => p.categoryId == category.id).toList();
      if (products.isNotEmpty) result[category] = products;
    }
    return result;
  }

  /// Flat filtered list used for search results
  List<ProductEntity> getFilteredProducts(HomeFeed feed) {
    if (state is! HomeLoaded) return feed.topItems;
    final loaded = state as HomeLoaded;

    if (loaded.searchQuery.isEmpty) return feed.topItems;

    final query = loaded.searchQuery.toLowerCase();
    return feed.topItems
        .where(
          (p) =>
              p.name.toLowerCase().contains(query) ||
              p.description.toLowerCase().contains(query),
        )
        .toList();
  }
}
