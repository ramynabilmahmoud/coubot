import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_paths.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:flutter/widgets.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
/// to print all routes in in stack
// print('routes: ${context.router.stack.map((e) => e.name).toList()}');
/// AppRouter
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute<void>(
      page: SplashRoute.page,
      path: AppPaths.splash,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute<void>(
      page: AuthWrapper.page,
      path: AppPaths.authWrapper,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        AutoRoute(initial: true, page: SignInRoute.page, path: AppPaths.signIn),
        AutoRoute(page: SignUpRoute.page, path: AppPaths.signUp),
        AutoRoute(page: OTPRoute.page, path: AppPaths.otp),
      ],
    ),
    CustomRoute<void>(
      page: AppLayoutWrapper.page,
      path: AppPaths.appLayoutWrapper,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        AutoRoute(
          initial: true,
          page: AppLayoutRoute.page,
          path: AppPaths.appLayout,
        ),
      ],
    ),
  ];

  /// i need to assign navigator key to this router
  /// so i can use it in main.dart
  @override
  GlobalKey<NavigatorState> get navigatorKey => super.navigatorKey;
}
