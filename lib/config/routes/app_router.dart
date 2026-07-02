import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_paths.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:flutter/widgets.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({GlobalKey<NavigatorState>? navigatorKey})
    : _navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  final List<AutoRoute> routes = [
    /// Splash
    CustomRoute<void>(
      page: SplashRoute.page,
      path: AppPaths.splash,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),

    /// Auth Wrapper
    CustomRoute<void>(
      page: AuthWrapper.page,
      path: AppPaths.authWrapper,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        AutoRoute(initial: true, page: SignInRoute.page, path: AppPaths.signIn),
        AutoRoute(page: SignUpRoute.page, path: AppPaths.signUp),
      ],
    ),

    /// Main App Layout
    CustomRoute<void>(
      page: AppLayoutWrapper.page,
      path: AppPaths.appLayoutWrapper,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),

    /// ✅ Product Details Page
    CustomRoute<void>(
      page: ProductsDetailsRoute.page,
      path: AppPaths.productDetails,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),

    CustomRoute<void>(
      page: CartRoute.page,
      path: AppPaths.cart,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
