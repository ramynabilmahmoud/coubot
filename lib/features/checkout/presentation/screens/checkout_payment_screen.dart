import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/core/presentation/widgets/custom_button.dart';
import 'package:coubot/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:coubot/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:coubot/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CheckoutPaymentScreen extends StatelessWidget {
  const CheckoutPaymentScreen({super.key});

  String _numberFor(String method) =>
      method == 'e_wallet' ? kEWalletNumber : kInstapayNumber;

  String _labelFor(String method) =>
      method == 'e_wallet' ? 'E-Wallet' : 'Instapay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.canPop()
              ? context.router.maybePop()
              : context.router.root.maybePop(),
        ),
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state.status == CheckoutStatus.success) {
            context.read<CartCubit>().clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully')),
            );
            context.router.root.replaceAll([const AppLayoutWrapper()]);
          } else if (state.status == CheckoutStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Failed to place order')),
            );
          }
        },
        builder: (context, state) {
          final method = state.paymentMethod!;
          final submitting = state.status == CheckoutStatus.submitting;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pay via ${_labelFor(method)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: context.textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SelectableText(
                        _numberFor(method),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Upload transaction screenshot',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.read<CheckoutCubit>().pickScreenshot(),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: state.screenshot == null
                        ? Center(
                            child: Icon(Icons.upload_outlined,
                                size: 36, color: context.mutedTextColor),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(
                              File(state.screenshot!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                  ),
                ),
                const Spacer(),
                submitting
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : CustomButton(
                        title: 'Place Order',
                        onPressed: state.canSubmit
                            ? () => context.read<CheckoutCubit>().submitOrder()
                            : () {},
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
