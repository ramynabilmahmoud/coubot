import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/data/models/cart_item_model.dart';
import '../cubit/checkout_cubit.dart';

@RoutePage()
class CheckoutWrapper extends StatelessWidget {
  const CheckoutWrapper({
    required this.items,
    required this.total,
    super.key,
  });

  final List<CartItemModel> items;
  final double total;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(items: items, total: total),
      child: const AutoRouter(),
    );
  }
}
