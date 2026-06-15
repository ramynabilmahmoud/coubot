import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasrouce/local/cart_local_data_source.dart';
import '../../data/models/cart_item_model.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(this._local) : super( CartInitial());

  final CartLocalDataSource _local;

  ValueListenable? _listenable;
  VoidCallback? _listener;
  bool _started = false;

  /// Call once (ex: in AppLayout or Home) to keep badge + cart updated live.
  void start() {
    if (_started) return;
    _started = true;

    emit( CartLoading()); // ✅ show loading once

    // ✅ attach listener
    _listenable = _local.listenable();
    _listener = _emit;

    _listenable!.addListener(_listener!);

    // ✅ emit current data immediately (so loading won't stay)
    _emit();
  }

  void _emit() {
    final items = _local.getAll();
    final itemsCount = items.length;
    final totalQty = items.fold<int>(0, (sum, e) => sum + e.quantity);

    emit(CartLoaded(
      items: items,
      itemsCount: itemsCount,
      totalQuantity: totalQty,
    ));
  }

  Future<void> add({
    required String productId,
    required String title,
    required String subtitle,
    required double price,
    String? imageUrl,
    int qty = 1,
  }) async {
    try {
      await _local.addOrIncrement(
        CartItemModel(
          productId: productId,
          title: title,
          subtitle: subtitle,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
        qty: qty,
      );
      // no emit here, listener will update
    } catch (e) {
      emit(CartError(e.toString()));
      _emit();
    }
  }

  Future<void> increment(String productId) async {
    try {
      await _local.increment(productId);
    } catch (e) {
      emit(CartError(e.toString()));
      _emit();
    }
  }

  Future<void> decrement(String productId) async {
    try {
      await _local.decrement(productId);
    } catch (e) {
      emit(CartError(e.toString()));
      _emit();
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await _local.remove(productId);
    } catch (e) {
      emit(CartError(e.toString()));
      _emit();
    }
  }

  Future<void> clearCart() async {
    try {
      await _local.clear();
    } catch (e) {
      emit(CartError(e.toString()));
      _emit();
    }
  }

  Future<bool> checkout() async {
    final current = state;
    if (current is! CartLoaded || current.items.isEmpty) return false;

    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser!.id;

      final orderRow = await client
          .from('orders')
          .insert({
            'customer_id': userId,
            'status': 'pending',
            'total_price': current.total,
          })
          .select('id')
          .single();

      final orderId = orderRow['id'] as int;

      await client.from('order_products').insert(
        current.items
            .map((item) => {
                  'order_id': orderId,
                  'product_id': item.productId,
                  'quantity': item.quantity,
                })
            .toList(),
      );

      await clearCart();
      return true;
    } catch (e) {
      emit(CartError(e.toString()));
      _emit();
      return false;
    }
  }

  bool isInCart(String productId) {
    final s = state;
    if (s is! CartLoaded) return false;
    return s.items.any((e) => e.productId == productId);
  }

  @override
  Future<void> close() async {
    if (_listenable != null && _listener != null) {
      _listenable!.removeListener(_listener!);
    }
    return super.close();
  }
}
