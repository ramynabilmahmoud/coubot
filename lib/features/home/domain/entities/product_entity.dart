class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool onSale;
  final double price;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.onSale,
    required this.price,
    required this.rating,
  });
}
