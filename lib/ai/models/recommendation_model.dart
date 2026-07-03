import 'package:coubot/features/home/domain/entities/product_entity.dart';

class RecommendationModel {
  final String id;
  final String? categoryId;
  final String name;
  final String? nameAr;
  final String description;
  final String? descriptionAr;
  final double price;
  final int estimatedTime;
  final String imageUrl;
  final String reason;

  RecommendationModel({
    required this.id,
    this.categoryId,
    required this.name,
    this.nameAr,
    required this.description,
    this.descriptionAr,
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
      nameAr: product['name_ar'] as String?,
      description: product['description'] as String? ?? '',
      descriptionAr: product['description_ar'] as String?,
      price: (product['price'] as num?)?.toDouble() ?? 0,
      estimatedTime: (product['estimated_time'] as num?)?.toInt() ?? 0,
      imageUrl: product['image_url'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );
  }

  String localizedName(String langCode) =>
      langCode == 'ar' && nameAr != null && nameAr!.isNotEmpty ? nameAr! : name;

  String localizedDescription(String langCode) =>
      langCode == 'ar' && descriptionAr != null && descriptionAr!.isNotEmpty
          ? descriptionAr!
          : description;

  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      name: name,
      nameAr: nameAr,
      description: description,
      descriptionAr: descriptionAr,
      imageUrl: imageUrl,
      onSale: false,
      price: price,
      rating: 4.5,
      categoryId: categoryId,
    );
  }
}
