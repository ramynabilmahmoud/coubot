// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:coubot/features/app_layout/presentation/screens/app_layout_screen.dart'
    as _i1;
import 'package:coubot/features/app_splash/presentation/screens/splash_screen.dart'
    as _i8;
import 'package:coubot/features/auth/presentation/screens/change_password_screen/change_password_screen.dart'
    as _i3;
import 'package:coubot/features/auth/presentation/screens/sign_in/sign_in_screen.dart'
    as _i6;
import 'package:coubot/features/auth/presentation/screens/sign_up/sign_up_screen.dart'
    as _i7;
import 'package:coubot/features/auth/presentation/wrappers/auth_wrapper.dart'
    as _i2;
import 'package:coubot/features/home/domain/entities/product.dart' as _i11;
import 'package:coubot/features/home/presentation/pages/product_details_screen.dart'
    as _i5;
import 'package:coubot/features/home/presentation/screens/home_screen.dart'
    as _i4;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.AppLayoutScreen]
class AppLayoutRoute extends _i9.PageRouteInfo<void> {
  const AppLayoutRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AppLayoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppLayoutRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppLayoutScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthWrapper]
class AuthWrapper extends _i9.PageRouteInfo<void> {
  const AuthWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          AuthWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthWrapper';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthWrapper();
    },
  );
}

/// generated route for
/// [_i3.ChangePasswordScreen]
class ChangePasswordRoute extends _i9.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.ProductsDetailsScreen]
class ProductsDetailsRoute extends _i9.PageRouteInfo<ProductsDetailsRouteArgs> {
  ProductsDetailsRoute({
    _i10.Key? key,
    required _i11.Product product,
    required bool isFavorite,
    required bool isInCart,
    required _i10.VoidCallback onAddToCart,
    required _i10.VoidCallback onToggleFavorite,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          ProductsDetailsRoute.name,
          args: ProductsDetailsRouteArgs(
            key: key,
            product: product,
            isFavorite: isFavorite,
            isInCart: isInCart,
            onAddToCart: onAddToCart,
            onToggleFavorite: onToggleFavorite,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsDetailsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductsDetailsRouteArgs>();
      return _i5.ProductsDetailsScreen(
        key: args.key,
        product: args.product,
        isFavorite: args.isFavorite,
        isInCart: args.isInCart,
        onAddToCart: args.onAddToCart,
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
    required this.isInCart,
    required this.onAddToCart,
    required this.onToggleFavorite,
  });

  final _i10.Key? key;

  final _i11.Product product;

  final bool isFavorite;

  final bool isInCart;

  final _i10.VoidCallback onAddToCart;

  final _i10.VoidCallback onToggleFavorite;

  @override
  String toString() {
    return 'ProductsDetailsRouteArgs{key: $key, product: $product, isFavorite: $isFavorite, isInCart: $isInCart, onAddToCart: $onAddToCart, onToggleFavorite: $onToggleFavorite}';
  }
}

/// generated route for
/// [_i6.SignInScreen]
class SignInRoute extends _i9.PageRouteInfo<void> {
  const SignInRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignInScreen();
    },
  );
}

/// generated route for
/// [_i7.SignUpScreen]
class SignUpRoute extends _i9.PageRouteInfo<void> {
  const SignUpRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i8.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashScreen();
    },
  );
}
