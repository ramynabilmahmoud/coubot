class CategoryEntity {
  final String id;
  final String title;
  final String iconKey; // e.g. "food", "drinks", "dessert"

  const CategoryEntity({required this.id, required this.title, required this.iconKey});
}
