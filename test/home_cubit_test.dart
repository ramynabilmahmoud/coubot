import 'package:coubot/features/home/domain/entities/category_entity.dart';
import 'package:coubot/features/home/domain/entities/product_entity.dart';
import 'package:coubot/features/home/domain/repositories/home_repository.dart';
import 'package:coubot/features/home/domain/usecases/get_home_feed.dart';
import 'package:coubot/features/home/presentation/cubits/home_cubit.dart';
import 'package:coubot/features/home/presentation/cubits/home_state.dart';
import 'package:flutter_test/flutter_test.dart';

// ── Fakes ────────────────────────────────────────────────────────────────────

class _FakeRepo implements HomeRepository {
  final HomeFeed feed;

  _FakeRepo({required this.feed});

  @override
  Future<HomeFeed> getHomeFeed() async => feed;

  @override
  Future<List<String>> getFavourites() async => [];

  @override
  Future<void> updateFavourites(List<String> productIds) async {}
}

// ── Helpers ──────────────────────────────────────────────────────────────────

ProductEntity _product(String id, {String name = 'P', String? categoryId}) =>
    ProductEntity(
      id: id,
      name: name,
      description: 'desc',
      imageUrl: 'url',
      onSale: false,
      price: 10.0,
      rating: 4.0,
      categoryId: categoryId,
    );

CategoryEntity _cat(String id, String title) =>
    CategoryEntity(id: id, title: title, iconKey: 'food');

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  group('HomeCubit.getProductsGroupedByCategory', () {
    test('groups products under their category', () {
      final catA = _cat('c1', 'Burgers');
      final catB = _cat('c2', 'Drinks');
      final products = [
        _product('p1', categoryId: 'c1'),
        _product('p2', categoryId: 'c1'),
        _product('p3', categoryId: 'c2'),
      ];
      final feed = HomeFeed(
        topItems: products,
        categories: [catA, catB],
        buyAgain: [],
      );
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      final grouped = cubit.getProductsGroupedByCategory(feed);

      expect(grouped[catA]?.length, 2);
      expect(grouped[catB]?.length, 1);
      expect(grouped.keys.length, 2);
    });

    test('omits categories with no products', () {
      final catA = _cat('c1', 'Burgers');
      final catB = _cat('c2', 'Drinks'); // no products
      final products = [_product('p1', categoryId: 'c1')];
      final feed = HomeFeed(
        topItems: products,
        categories: [catA, catB],
        buyAgain: [],
      );
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      final grouped = cubit.getProductsGroupedByCategory(feed);

      expect(grouped.containsKey(catB), isFalse);
      expect(grouped.keys.length, 1);
    });
  });

  group('HomeCubit.getFilteredProducts', () {
    test('returns all items when search query is empty', () {
      final products = [
        _product('p1', name: 'Burger'),
        _product('p2', name: 'Pizza'),
      ];
      final feed = HomeFeed(
        topItems: products,
        categories: [],
        buyAgain: [],
      );
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );
      // State is HomeInitial — returns all
      expect(cubit.getFilteredProducts(feed).length, 2);
    });

    test('filters products by name (case-insensitive)', () {
      final products = [
        _product('p1', name: 'Chicken Burger'),
        _product('p2', name: 'Veggie Pizza'),
        _product('p3', name: 'Chicken Wings'),
      ];
      final feed = HomeFeed(
        topItems: products,
        categories: [],
        buyAgain: [],
      );
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      // Put cubit in loaded state with a search query
      cubit.emit(HomeLoaded(feed: feed, searchQuery: 'chicken'));
      final filtered = cubit.getFilteredProducts(feed);

      expect(filtered.length, 2);
      expect(filtered.every((p) => p.name.toLowerCase().contains('chicken')), isTrue);
    });

    test('returns empty list when no products match', () {
      final products = [_product('p1', name: 'Burger')];
      final feed = HomeFeed(topItems: products, categories: [], buyAgain: []);
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      cubit.emit(HomeLoaded(feed: feed, searchQuery: 'sushi'));
      final filtered = cubit.getFilteredProducts(feed);

      expect(filtered, isEmpty);
    });
  });

  group('HomeCubit.toggleFavorite', () {
    test('adds product to favorites when not already favorited', () {
      final product = _product('p1', name: 'Burger');
      final feed = HomeFeed(topItems: [product], categories: [], buyAgain: []);
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      cubit.emit(HomeLoaded(feed: feed, favorites: []));
      cubit.toggleFavorite(product);

      final state = cubit.state as HomeLoaded;
      expect(state.favorites.contains('p1'), isTrue);
    });

    test('removes product from favorites when already favorited', () {
      final product = _product('p1', name: 'Burger');
      final feed = HomeFeed(topItems: [product], categories: [], buyAgain: []);
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      cubit.emit(HomeLoaded(feed: feed, favorites: ['p1']));
      cubit.toggleFavorite(product);

      final state = cubit.state as HomeLoaded;
      expect(state.favorites.contains('p1'), isFalse);
    });

    test('does nothing when state is not HomeLoaded', () {
      final product = _product('p1');
      final feed = HomeFeed(topItems: [], categories: [], buyAgain: []);
      final cubit = HomeCubit(
        GetHomeFeed(_FakeRepo(feed: feed)),
        _FakeRepo(feed: feed),
      );

      // State is HomeInitial — toggle should be a no-op
      cubit.toggleFavorite(product);
      expect(cubit.state, isA<HomeInitial>());
    });
  });
}
