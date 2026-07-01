import 'package:coubot/features/cart/data/models/cart_item_model.dart';
import 'package:coubot/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_test/flutter_test.dart';

CartItemModel _item(String id, double price, int qty) => CartItemModel(
      productId: id,
      title: 'Item $id',
      subtitle: 'Sub $id',
      price: price,
      quantity: qty,
    );

void main() {
  group('CartLoaded', () {
    test('subtotal sums price * quantity across all items', () {
      final state = CartLoaded(
        items: [_item('a', 10.0, 2), _item('b', 5.0, 3)],
        itemsCount: 2,
        totalQuantity: 5,
      );
      expect(state.subtotal, 35.0); // 20 + 15
    });

    test('total adds default delivery fee of 25 when items present', () {
      final state = CartLoaded(
        items: [_item('a', 50.0, 1)],
        itemsCount: 1,
        totalQuantity: 1,
      );
      expect(state.total, 75.0); // 50 + 25
    });

    test('total is 0 when items is empty', () {
      final state = CartLoaded(
        items: const [],
        itemsCount: 0,
        totalQuantity: 0,
      );
      expect(state.total, 0.0);
      expect(state.subtotal, 0.0);
    });

    test('total uses custom delivery fee', () {
      final state = CartLoaded(
        items: [_item('a', 100.0, 1)],
        itemsCount: 1,
        totalQuantity: 1,
        deliveryFee: 50.0,
      );
      expect(state.total, 150.0);
    });

    test('subtotal handles single item with quantity > 1', () {
      final state = CartLoaded(
        items: [_item('x', 7.5, 4)],
        itemsCount: 1,
        totalQuantity: 4,
      );
      expect(state.subtotal, 30.0);
    });
  });

  group('CartItemModel.copyWith', () {
    test('copyWith updates only provided fields', () {
      final original = _item('p1', 20.0, 1);
      final updated = original.copyWith(quantity: 3);
      expect(updated.productId, 'p1');
      expect(updated.price, 20.0);
      expect(updated.quantity, 3);
    });

    test('copyWith with no args returns identical values', () {
      final original = _item('p2', 15.0, 2);
      final copy = original.copyWith();
      expect(copy.productId, original.productId);
      expect(copy.price, original.price);
      expect(copy.quantity, original.quantity);
    });
  });
}
