class CategoryEntity {
  final String id;
  final String title;
  final String? titleAr;
  final String iconKey;

  const CategoryEntity({
    required this.id,
    required this.title,
    this.titleAr,
    required this.iconKey,
  });

  String localizedTitle(String langCode) =>
      langCode == 'ar' && titleAr != null && titleAr!.isNotEmpty ? titleAr! : title;
}
