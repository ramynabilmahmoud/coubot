import 'package:coubot/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:coubot/features/cart/presentation/cubit/cart_state.dart';
import 'package:coubot/features/cart/presentation/widgets/cart_item_card_widget.dart';
import 'package:coubot/features/cart/presentation/widgets/cart_summary_row_widget.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';

class CartMobileScreen extends StatelessWidget {
  const CartMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).myCart,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => context.read<CartCubit>().clearCart(),
            icon: const Icon(Icons.delete_outline, color: Colors.white),
          )
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial || state is CartLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is CartError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: AppColors.mutedText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          final loaded = state as CartLoaded;

          if (loaded.items.isEmpty) {
            return Center(
              child: Text(
                S.of(context).cartIsEmpty,
                style: const TextStyle(
                  color: AppColors.mutedText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return Column(
            children: [
              /// Cart Items
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: loaded.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = loaded.items[index];

                    return CartItemCardWidget(
                      title: item.title,
                      subtitle: item.subtitle,
                      price: item.price,
                      quantity: item.quantity,
                      imageUrl: item.imageUrl,
                      onPlus: () => context.read<CartCubit>().increment(item.productId),
                      onMinus: () => context.read<CartCubit>().decrement(item.productId),
                      onRemove: () => context.read<CartCubit>().removeFromCart(item.productId),
                    );
                  },
                ),
              ),

              /// Bottom Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CartSummaryRow(
                      title: S.of(context).subtotal,
                      value: "${loaded.subtotal.toStringAsFixed(0)} EGP",
                    ),
                    const SizedBox(height: 8),
                    CartSummaryRow(
                      title: S.of(context).delivery,
                      value: "${loaded.deliveryFee.toStringAsFixed(0)} EGP",
                    ),
                    const Divider(height: 24),
                    CartSummaryRow(
                      title: S.of(context).total,
                      value: "${loaded.total.toStringAsFixed(0)} EGP",
                      isTotal: true,
                    ),
                    const SizedBox(height: 16),

                    /// Checkout Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          // later: checkout
                        },
                        child: Text(
                        S.of(context).checkout,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
