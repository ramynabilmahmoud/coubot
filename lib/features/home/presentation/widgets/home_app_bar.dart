import 'package:coubot/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../config/routes/app_router.gr.dart';
import '../../../../config/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
               Text(
                S.of(context).coubot,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: BlocBuilder<CartCubit, CartState>(
                  buildWhen: (prev, next) {
                    final prevQty = prev is CartLoaded ? prev.totalQuantity : 0;
                    final nextQty = next is CartLoaded ? next.totalQuantity : 0;
                    return prevQty != nextQty;
                  },
                  builder: (context, state) {
                    final qty = (state is CartLoaded) ? state.totalQuantity : 0;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          onPressed: () => context.router.push(const CartRoute()),
                          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        ),

                        if (qty > 0)
                          Positioned(
                            right: 4,
                            top: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "$qty",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
