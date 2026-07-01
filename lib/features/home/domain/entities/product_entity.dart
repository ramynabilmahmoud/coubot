class ProductEntity {
  final String id;
  final String name;
  final String? nameAr;
  final String description;
  final String? descriptionAr;
  final String imageUrl;
  final bool onSale;
  final double price;
  final double rating;
  final String? categoryId;

  const ProductEntity({
    required this.id,
    required this.name,
    this.nameAr,
    required this.description,
    this.descriptionAr,
    required this.imageUrl,
    required this.onSale,
    required this.price,
    required this.rating,
    this.categoryId,
  });

  String localizedName(String langCode) =>
      langCode == 'ar' && nameAr != null && nameAr!.isNotEmpty ? nameAr! : name;

  String localizedDescription(String langCode) =>
      langCode == 'ar' && descriptionAr != null && descriptionAr!.isNotEmpty
          ? descriptionAr!
          : description;
}
