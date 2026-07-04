import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/core/presentation/widgets/custom_button.dart';
import 'package:coubot/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:coubot/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:coubot/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CheckoutPaymentScreen extends StatelessWidget {
  const CheckoutPaymentScreen({super.key});

  String _numberFor(String method) =>
      method == 'e_wallet' ? kEWalletNumber : kInstapayNumber;

  String _labelFor(BuildContext context, String method) =>
      method == 'e_wallet' ? S.of(context).eWallet : S.of(context).instapay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).payment),
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
              SnackBar(content: Text(S.of(context).orderPlacedSuccessfully)),
            );
            context.router.root.replaceAll([const AppLayoutWrapper()]);
          } else if (state.status == CheckoutStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? S.of(context).failedToPlaceOrder)),
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
                        S.of(context).payVia(_labelFor(context, method)),
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
                  S.of(context).uploadTransactionScreenshot,
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
                        title: S.of(context).placeOrder,
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
