import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/core/presentation/widgets/custom_button.dart';
import 'package:coubot/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:coubot/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_router.gr.dart';

@RoutePage()
class CheckoutLocationScreen extends StatelessWidget {
  const CheckoutLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).checkout),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.canPop()
              ? context.router.maybePop()
              : context.router.root.maybePop(),
        ),
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).selectHall,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: kCheckoutHalls.map((hall) {
                    final selected = state.hall == hall;
                    return ChoiceChip(
                      label: Text(hall),
                      selected: selected,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : context.textColor,
                        fontWeight: FontWeight.w700,
                      ),
                      onSelected: (_) =>
                          context.read<CheckoutCubit>().selectHall(hall),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
                Text(
                  S.of(context).paymentMethod,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                _PaymentMethodTile(
                  label: S.of(context).eWallet,
                  value: 'e_wallet',
                  selected: state.paymentMethod == 'e_wallet',
                ),
                const SizedBox(height: 10),
                _PaymentMethodTile(
                  label: S.of(context).instapay,
                  value: 'instapay',
                  selected: state.paymentMethod == 'instapay',
                ),
                const Spacer(),
                CustomButton(
                  title: S.of(context).next,
                  onPressed: state.canProceedToPayment
                      ? () => context.router.push(const CheckoutPaymentRoute())
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

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.label,
    required this.value,
    required this.selected,
  });

  final String label;
  final String value;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => context.read<CheckoutCubit>().selectPaymentMethod(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primary : context.mutedTextColor,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: context.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
