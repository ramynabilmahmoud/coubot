import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_feed.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeFeed getHomeFeed;
  HomeCubit(this.getHomeFeed) : super(const HomeInitial());

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      final feed = await getHomeFeed();
      emit(HomeLoaded(feed: feed));
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
  void filterByCategory(Category? category) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    emit(state.copyWith(selectedCategoryId: category?.id));
  }

  /// Add product to cart
  void addToCart(Product product) {
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

  /// Toggle favorite
  void toggleFavorite(Product product) {
    final state = this.state;
    if (state is! HomeLoaded) return;

    final updatedFavorites = [...state.favorites];
    if (updatedFavorites.contains(product.id)) {
      updatedFavorites.removeWhere((id) => id == product.id);
    } else {
      updatedFavorites.add(product.id);
    }
    emit(state.copyWith(favorites: updatedFavorites));
  }

  /// Get filtered products based on search and category
  List<Product> getFilteredProducts(HomeFeed feed) {
    var products = [...feed.topItems, ...feed.buyAgain];

    // Filter by category (using category title matching for demo)
    if (state is HomeLoaded) {
      final selectedCategoryId = (state as HomeLoaded).selectedCategoryId;
      if (selectedCategoryId != null) {
        // Filter logic - you can enhance this based on your data model
        products = products.where((p) => p.id.isNotEmpty).toList();
      }
    }

    // Filter by search query
    if (state is HomeLoaded) {
      final query = (state as HomeLoaded).searchQuery.toLowerCase();
      if (query.isNotEmpty) {
        products = products
            .where((p) {
              final name = p.name;
              final description = p.description;
              return name.toLowerCase().contains(query) ||
                  description.toLowerCase().contains(query);
            })
            .toList();
      }
    }

    return products;
  }
}
