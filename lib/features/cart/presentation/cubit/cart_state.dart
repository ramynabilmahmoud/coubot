import '../../data/models/cart_item_model.dart';

 class CartState {
}

class CartInitial extends CartState {
}

class CartLoading extends CartState {
}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final int itemsCount;
  final int totalQuantity;
  final double deliveryFee;

   CartLoaded({
    required this.items,
    required this.itemsCount,
    required this.totalQuantity,
    this.deliveryFee = 25.0,
  });

  double get subtotal =>
      items.fold(0.0, (sum, e) => sum + (e.price * e.quantity));

  double get total => items.isEmpty ? 0 : subtotal + deliveryFee;
}

class CartError extends CartState {
  final String message;
   CartError(this.message);
}
