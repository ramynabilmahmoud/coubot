import 'package:coubot/features/home/domain/entities/product_entity.dart';

class RecommendationModel {
  final String id;
  final String? categoryId;
  final String name;
  final String description;
  final double price;
  final int estimatedTime;
  final String imageUrl;
  final String reason;

  RecommendationModel({
    required this.id,
    this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedTime,
    required this.imageUrl,
    required this.reason,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    final product = Map<String, dynamic>.from(json['product'] as Map);

    return RecommendationModel(
      id: product['id'].toString(),
      categoryId: product['category_id']?.toString(),
      name: product['name'] as String? ?? '',
      description: product['description'] as String? ?? '',
      price: (product['price'] as num?)?.toDouble() ?? 0,
      estimatedTime: (product['estimated_time'] as num?)?.toInt() ?? 0,
      imageUrl: product['image_url'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      onSale: false,
      price: price,
      rating: 4.5,
      categoryId: categoryId,
    );
  }
}
