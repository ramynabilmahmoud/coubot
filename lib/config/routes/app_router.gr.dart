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
import 'package:coubot/features/app_layout/presentation/wrappers/app_layout_wrapper.dart'
    as _i2;
import 'package:coubot/features/app_splash/presentation/screens/splash_screen.dart'
    as _i8;
import 'package:coubot/features/auth/presentation/screens/change_password_screen/change_password_screen.dart'
    as _i4;
import 'package:coubot/features/auth/presentation/screens/otp_screen/otp_screen.dart'
    as _i5;
import 'package:coubot/features/auth/presentation/screens/sign_in/sign_in_screen.dart'
    as _i6;
import 'package:coubot/features/auth/presentation/screens/sign_up/sign_up_screen.dart'
    as _i7;
import 'package:coubot/features/auth/presentation/wrappers/auth_wrapper.dart'
    as _i3;
import 'package:flutter/material.dart' as _i11;
import 'package:supabase_flutter/supabase_flutter.dart' as _i10;

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
/// [_i2.AppLayoutWrapper]
class AppLayoutWrapper extends _i9.PageRouteInfo<void> {
  const AppLayoutWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          AppLayoutWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AppLayoutWrapper';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppLayoutWrapper();
    },
  );
}

/// generated route for
/// [_i3.AuthWrapper]
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
      return const _i3.AuthWrapper();
    },
  );
}

/// generated route for
/// [_i4.ChangePasswordScreen]
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
      return const _i4.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i5.OTPScreen]
class OTPRoute extends _i9.PageRouteInfo<OTPRouteArgs> {
  OTPRoute({
    required _i10.OtpType otpType,
    required String emailToVerify,
    _i11.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          OTPRoute.name,
          args: OTPRouteArgs(
            otpType: otpType,
            emailToVerify: emailToVerify,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPRouteArgs>();
      return _i5.OTPScreen(
        otpType: args.otpType,
        emailToVerify: args.emailToVerify,
        key: args.key,
      );
    },
  );
}

class OTPRouteArgs {
  const OTPRouteArgs({
    required this.otpType,
    required this.emailToVerify,
    this.key,
  });

  final _i10.OtpType otpType;

  final String emailToVerify;

  final _i11.Key? key;

  @override
  String toString() {
    return 'OTPRouteArgs{otpType: $otpType, emailToVerify: $emailToVerify, key: $key}';
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
