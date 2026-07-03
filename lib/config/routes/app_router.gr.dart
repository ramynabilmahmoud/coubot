// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:coubot/features/app_layout/presentation/wrappers/app_layout_wrapper.dart'
    as _i1;
import 'package:coubot/features/app_splash/presentation/screens/splash_screen.dart'
    as _i13;
import 'package:coubot/features/auth/presentation/screens/change_password_screen/change_password_screen.dart'
    as _i4;
import 'package:coubot/features/auth/presentation/screens/sign_in/sign_in_screen.dart'
    as _i11;
import 'package:coubot/features/auth/presentation/screens/sign_up/sign_up_screen.dart'
    as _i12;
import 'package:coubot/features/auth/presentation/wrappers/auth_wrapper.dart'
    as _i2;
import 'package:coubot/features/cart/data/models/cart_item_model.dart' as _i15;
import 'package:coubot/features/cart/presentation/screens/cart_screen.dart'
    as _i3;
import 'package:coubot/features/checkout/presentation/screens/checkout_location_screen.dart'
    as _i5;
import 'package:coubot/features/checkout/presentation/screens/checkout_payment_screen.dart'
    as _i6;
import 'package:coubot/features/checkout/presentation/wrappers/checkout_wrapper.dart'
    as _i7;
import 'package:coubot/features/home/domain/entities/product_entity.dart'
    as _i17;
import 'package:coubot/features/home/presentation/pages/product_details_screen.dart'
    as _i10;
import 'package:coubot/features/home/presentation/screens/home_screen.dart'
    as _i8;
import 'package:coubot/features/notifications/presentation/screens/notifications_screen.dart'
    as _i9;
import 'package:flutter/material.dart' as _i16;

/// generated route for
/// [_i1.AppLayoutWrapper]
class AppLayoutWrapper extends _i14.PageRouteInfo<void> {
  const AppLayoutWrapper({List<_i14.PageRouteInfo>? children})
      : super(
          AppLayoutWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AppLayoutWrapper';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppLayoutWrapper();
    },
  );
}

/// generated route for
/// [_i2.AuthWrapper]
class AuthWrapper extends _i14.PageRouteInfo<void> {
  const AuthWrapper({List<_i14.PageRouteInfo>? children})
      : super(
          AuthWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthWrapper';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthWrapper();
    },
  );
}

/// generated route for
/// [_i3.CartScreen]
class CartRoute extends _i14.PageRouteInfo<void> {
  const CartRoute({List<_i14.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.CartScreen();
    },
  );
}

/// generated route for
/// [_i4.ChangePasswordScreen]
class ChangePasswordRoute extends _i14.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i5.CheckoutLocationScreen]
class CheckoutLocationRoute extends _i14.PageRouteInfo<void> {
  const CheckoutLocationRoute({List<_i14.PageRouteInfo>? children})
      : super(
          CheckoutLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutLocationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.CheckoutLocationScreen();
    },
  );
}

/// generated route for
/// [_i6.CheckoutPaymentScreen]
class CheckoutPaymentRoute extends _i14.PageRouteInfo<void> {
  const CheckoutPaymentRoute({List<_i14.PageRouteInfo>? children})
      : super(
          CheckoutPaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutPaymentRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.CheckoutPaymentScreen();
    },
  );
}

/// generated route for
/// [_i7.CheckoutWrapper]
class CheckoutWrapper extends _i14.PageRouteInfo<CheckoutWrapperArgs> {
  CheckoutWrapper({
    required List<_i15.CartItemModel> items,
    required double total,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          CheckoutWrapper.name,
          args: CheckoutWrapperArgs(
            items: items,
            total: total,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutWrapper';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckoutWrapperArgs>();
      return _i7.CheckoutWrapper(
        items: args.items,
        total: args.total,
        key: args.key,
      );
    },
  );
}

class CheckoutWrapperArgs {
  const CheckoutWrapperArgs({
    required this.items,
    required this.total,
    this.key,
  });

  final List<_i15.CartItemModel> items;

  final double total;

  final _i16.Key? key;

  @override
  String toString() {
    return 'CheckoutWrapperArgs{items: $items, total: $total, key: $key}';
  }
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.HomeScreen();
    },
  );
}

/// generated route for
/// [_i9.NotificationsScreen]
class NotificationsRoute extends _i14.PageRouteInfo<void> {
  const NotificationsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.NotificationsScreen();
    },
  );
}

/// generated route for
/// [_i10.ProductsDetailsScreen]
class ProductsDetailsRoute
    extends _i14.PageRouteInfo<ProductsDetailsRouteArgs> {
  ProductsDetailsRoute({
    _i16.Key? key,
    required _i17.ProductEntity product,
    required bool isFavorite,
    required _i16.VoidCallback onToggleFavorite,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ProductsDetailsRoute.name,
          args: ProductsDetailsRouteArgs(
            key: key,
            product: product,
            isFavorite: isFavorite,
            onToggleFavorite: onToggleFavorite,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsDetailsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductsDetailsRouteArgs>();
      return _i10.ProductsDetailsScreen(
        key: args.key,
        product: args.product,
        isFavorite: args.isFavorite,
        onToggleFavorite: args.onToggleFavorite,
      );
    },
  );
}

class ProductsDetailsRouteArgs {
  const ProductsDetailsRouteArgs({
    this.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final _i16.Key? key;

  final _i17.ProductEntity product;

  final bool isFavorite;

  final _i16.VoidCallback onToggleFavorite;

  @override
  String toString() {
    return 'ProductsDetailsRouteArgs{key: $key, product: $product, isFavorite: $isFavorite, onToggleFavorite: $onToggleFavorite}';
  }
}

/// generated route for
/// [_i11.SignInScreen]
class SignInRoute extends _i14.PageRouteInfo<void> {
  const SignInRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SignInScreen();
    },
  );
}

/// generated route for
/// [_i12.SignUpScreen]
class SignUpRoute extends _i14.PageRouteInfo<void> {
  const SignUpRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i13.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.SplashScreen();
    },
  );
}
