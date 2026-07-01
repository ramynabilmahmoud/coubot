import '../../../home/domain/repositories/home_repository.dart';

 class HomeState {
}

class HomeInitial extends HomeState {
}

class HomeLoading extends HomeState {
}

class HomeLoaded extends HomeState {
  final HomeFeed feed;
  final List<String> cartItems; // product IDs in cart
  final List<String> favorites; // product IDs in favorites
  final String searchQuery;
  final String? selectedCategoryId;

   HomeLoaded({
    required this.feed,
    this.cartItems = const [],
    this.favorites = const [],
    this.searchQuery = '',
    this.selectedCategoryId,
  });

  HomeLoaded copyWith({
    HomeFeed? feed,
    List<String>? cartItems,
    List<String>? favorites,
    String? searchQuery,
    String? selectedCategoryId,
  }) {
    return HomeLoaded(
      feed: feed ?? this.feed,
      cartItems: cartItems ?? this.cartItems,
      favorites: favorites ?? this.favorites,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}

class HomeError extends HomeState {
  final String message;
   HomeError(this.message);
}
