import 'package:image_picker/image_picker.dart';

enum CheckoutStatus { idle, submitting, success, error }

class CheckoutState {
  final String? hall;
  final String? paymentMethod; // 'e_wallet' | 'instapay'
  final XFile? screenshot;
  final CheckoutStatus status;
  final String? errorMessage;

  const CheckoutState({
    this.hall,
    this.paymentMethod,
    this.screenshot,
    this.status = CheckoutStatus.idle,
    this.errorMessage,
  });

  bool get canProceedToPayment => hall != null && paymentMethod != null;

  bool get canSubmit => canProceedToPayment && screenshot != null;

  CheckoutState copyWith({
    String? hall,
    String? paymentMethod,
    XFile? screenshot,
    CheckoutStatus? status,
    String? errorMessage,
  }) {
    return CheckoutState(
      hall: hall ?? this.hall,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      screenshot: screenshot ?? this.screenshot,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
