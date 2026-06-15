import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

class HomeFeed {
  final List<ProductEntity> topItems;
  final List<CategoryEntity> categories;
  final List<ProductEntity> buyAgain;

  const HomeFeed({
    required this.topItems,
    required this.categories,
    required this.buyAgain,
  });
}

abstract class HomeRepository {
  Future<HomeFeed> getHomeFeed();
  Future<List<String>> getFavourites();
  Future<void> updateFavourites(List<String> productIds);
}
