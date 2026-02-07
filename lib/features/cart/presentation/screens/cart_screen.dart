import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/presentation/widgets/adaptive_layout.dart';
import 'package:coubot/features/cart/presentation/screens/cart_mobile_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return AdaptiveLayout(
        mobileLayout: (context) => const CartMobileScreen(),
        tabletLayout: (context) => const CartMobileScreen(),
        webLayout: (context) => const CartMobileScreen(),
      );
  }
}
 