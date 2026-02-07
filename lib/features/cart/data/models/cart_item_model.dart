import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 10)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subtitle;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final String? imageUrl;

   CartItemModel({
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  CartItemModel copyWith({
    String? productId,
    String? title,
    String? subtitle,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
