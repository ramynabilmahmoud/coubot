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
      imageUrl: json['image_url'] as String? ?? 'https://via.placeholder.com/600x400?text=${json['name']}',
      onSale: false, // Default value since Supabase doesn't have this field
    );
  }

  /// Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  static List<ProductModel> samplesTop() => const [
        ProductModel(
          id: "p1",
          name: "Fries",
          description: "Fresh golden fries",
          price: 150,
          rating: 4.9,
          imageUrl: "https://picsum.photos/seed/fries/600/400",
          onSale: true,
        ),
        ProductModel(
          id: "p2",
          name: "Burger",
          description: "Double beef burger",
          price: 220,
          rating: 4.7,
          imageUrl: "https://picsum.photos/seed/burger/600/400",
          onSale: true,
        ),
        ProductModel(
          id: "p3",
          name: "Pizza",
          description: "Cheesy slice",
          price: 300,
          rating: 4.8,
          imageUrl: "https://picsum.photos/seed/pizza/600/400",
          onSale: false,
        ),
      ];

  static List<ProductModel> samplesBuyAgain() => const [
        ProductModel(
          id: "p4",
          name: "Fries",
          description: "Fresh golden fries",
          price: 150,
          rating: 4.9,
          imageUrl: "https://picsum.photos/seed/fries2/600/400",
          onSale: true,
        ),
        ProductModel(
          id: "p5",
          name: "Cola",
          description: "Chilled drink",
          price: 60,
          rating: 4.6,
          imageUrl: "https://picsum.photos/seed/cola/600/400",
          onSale: false,
        ),
        ProductModel(
          id: "p6",
          name: "Cake",
          description: "Strawberry slice",
          price: 180,
          rating: 4.8,
          imageUrl: "https://picsum.photos/seed/cake/600/400",
          onSale: true,
        ),
      ];
}
