import 'package:coubot/core/utils/database_manager.dart';
import 'package:coubot/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartLocalDataSource {
  CartLocalDataSource();

  Box<CartItemModel> get _box => Hive.box<CartItemModel>(DataBoxes.cart.name);

  List<CartItemModel> getAll() => _box.values.toList();

  ValueListenable<Box<CartItemModel>> listenable() => _box.listenable();

  Future<void> addOrIncrement(CartItemModel item, {int qty = 1}) async {
    final existing = _box.get(item.productId);

    if (existing == null) {
      await _box.put(item.productId, item.copyWith(quantity: qty));
    } else {
      await _box.put(item.productId, existing.copyWith(quantity: existing.quantity + qty));
    }
  }

  Future<void> increment(String productId) async {
    final existing = _box.get(productId);
    if (existing == null) return;
    await _box.put(productId, existing.copyWith(quantity: existing.quantity + 1));
  }

  Future<void> decrement(String productId) async {
    final existing = _box.get(productId);
    if (existing == null) return;

    final newQty = existing.quantity - 1;
    if (newQty <= 0) {
      await _box.delete(productId);
    } else {
      await _box.put(productId, existing.copyWith(quantity: newQty));
    }
  }

  Future<void> remove(String productId) => _box.delete(productId);
  Future<void> clear() => _box.clear();
}
