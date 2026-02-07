import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final bool onSale;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.onSale,
  });

  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    description: description,
    price: price,
    rating: rating,
    imageUrl: imageUrl,
    onSale: onSale,
  );

  /// Create ProductModel from Supabase JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? 'No description',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: 4.5, // Default rating since Supabase doesn't have this field
      imageUrl:
          json['image_url'] as String? ??
          'https://via.placeholder.com/600x400?text=${json['name']}',
      onSale: false, // Default value since Supabase doesn't have this field
    );
  }

  /// Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'price': price};
  }
}
