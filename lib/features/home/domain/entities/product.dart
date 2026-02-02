class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool onSale;
  final double price;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.onSale,
    required this.price,
    required this.rating,
  });

  /// ✅ استخدم ده بدل imageUrl في الـ UI
  String get safeImageUrl {
    final url = imageUrl.trim();

    if (url.isEmpty) {
      return "https://picsum.photos/seed/$id/900/600";
    }

    // ✅ بدّل via.placeholder.com لأنه بيعمل DNS fail عندك
    if (url.contains('via.placeholder.com')) {
      return "https://picsum.photos/seed/$id/900/600";
    }

    return url;
  }
}
