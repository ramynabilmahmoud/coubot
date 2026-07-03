import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../cart/data/models/cart_item_model.dart';
import 'checkout_state.dart';

/// Fixed hall list the buyer picks a pickup/delivery location from.
const List<String> kCheckoutHalls = ['A101', 'A102', 'A103', 'A104'];

const String kEWalletNumber = '01094419501';
const String kInstapayNumber = '01149935742';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.items,
    required this.total,
  }) : super(const CheckoutState());

  final List<CartItemModel> items;
  final double total;

  final _picker = ImagePicker();

  void selectHall(String hall) => emit(state.copyWith(hall: hall));

  void selectPaymentMethod(String method) =>
      emit(state.copyWith(paymentMethod: method));

  Future<void> pickScreenshot() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) emit(state.copyWith(screenshot: file));
  }

  Future<bool> submitOrder() async {
    if (!state.canSubmit) return false;

    emit(state.copyWith(status: CheckoutStatus.submitting));

    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser!.id;

      final bytes = await state.screenshot!.readAsBytes();
      final ext = state.screenshot!.name.split('.').last;
      final path =
          '$userId/${DateTime.now().millisecondsSinceEpoch}.$ext';

      await client.storage.from('payment-screenshots').uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(contentType: 'image/$ext'),
          );

      final screenshotUrl =
          client.storage.from('payment-screenshots').getPublicUrl(path);

      final orderRow = await client
          .from('orders')
          .insert({
            'customer_id': userId,
            'status': 'pending',
            'total_price': total,
            'location': state.hall,
            'payment_method': state.paymentMethod,
            'payment_screenshot_url': screenshotUrl,
          })
          .select('id')
          .single();

      final orderId = orderRow['id'] as int;

      await client.from('order_products').insert(
        items
            .map((item) => {
                  'order_id': orderId,
                  'product_id': item.productId,
                  'quantity': item.quantity,
                })
            .toList(),
      );

      emit(state.copyWith(status: CheckoutStatus.success));
      return true;
    } catch (e) {
      emit(state.copyWith(
        status: CheckoutStatus.error,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }
}
