import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// AppLayoutScreenMobile is used to manage the app layout for mobile devices
class AppLayoutScreenMobile extends StatelessWidget {
  /// AppLayoutScreenMobile constructor
  const AppLayoutScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // routes: const [HomeTab(), MyTripsTab(), AccountTab()],
      builder: (context, child) {
        // final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(body: child);
      },
    );
  }
}
