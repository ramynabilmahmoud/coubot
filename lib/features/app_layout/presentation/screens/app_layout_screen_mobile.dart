import 'package:auto_route/auto_route.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';

/// AppLayoutScreenMobile is used to manage the app layout for mobile devices
class AppLayoutScreenMobile extends StatelessWidget {
  /// AppLayoutScreenMobile constructor
  const AppLayoutScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: S.of(context).home),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: S.of(context).profile),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: S.of(context).orders),
            ],
          ),
        );
      },
    );
  }
}
