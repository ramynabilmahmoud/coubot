import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String? nameAr;
  final String description;
  final String? descriptionAr;
  final double price;
  final double rating;
  final String imageUrl;
  final bool onSale;
  final String? categoryId;

  const ProductModel({
    required this.id,
    required this.name,
    this.nameAr,
    required this.description,
    this.descriptionAr,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.onSale,
    this.categoryId,
  });

  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    nameAr: nameAr,
    description: description,
    descriptionAr: descriptionAr,
    price: price,
    rating: rating,
    imageUrl: imageUrl,
    onSale: onSale,
    categoryId: categoryId,
  );

  /// Create ProductModel from Supabase JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Unknown',
      nameAr: json['name_ar'] as String?,
      description: json['description'] as String? ?? 'No description',
      descriptionAr: json['description_ar'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: 4.5,
      imageUrl:
          json['image_url'] as String? ??
          'https://via.placeholder.com/600x400?text=${json['name']}',
      onSale: false,
      categoryId: json['category_id']?.toString(),
    );
  }

  /// Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'price': price};
  }
}
