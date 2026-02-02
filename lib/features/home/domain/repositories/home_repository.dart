import '../entities/category.dart';
import '../entities/product.dart';

class HomeFeed {
  final List<Product> topItems;
  final List<Category> categories;
  final List<Product> buyAgain;

  const HomeFeed({
    required this.topItems,
    required this.categories,
    required this.buyAgain,
  });
}

abstract class HomeRepository {
  Future<HomeFeed> getHomeFeed();
}
