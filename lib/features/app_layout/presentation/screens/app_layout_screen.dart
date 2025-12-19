import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/presentation/widgets/adaptive_layout.dart';
import 'package:coubot/features/app_layout/presentation/cubit/app_layout/app_layout_cubit.dart';
import 'package:coubot/features/app_layout/presentation/screens/app_layout_screen_mobile.dart';
import 'package:coubot/features/app_layout/presentation/screens/app_layout_screen_tablet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

/// AppLayoutScreen is used to manage the app layout
@RoutePage()
class AppLayoutScreen extends StatelessWidget {
  /// AppLayoutScreen constructor
  const AppLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutCubit, AppLayoutState>(
      buildWhen: (previous, current) =>
          current.appVersion != null &&
          previous.appVersion != current.appVersion,
      builder: (context, state) {
        return UpgradeAlert(
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          showIgnore: false,
          showLater: false,
          upgrader: Upgrader(
            // get the current app version
            minAppVersion: state.appVersion,
            durationUntilAlertAgain: const Duration(hours: 5),
          ),
          child: AdaptiveLayout(
            mobileLayout: (context) => const AppLayoutScreenMobile(),
            tabletLayout: (context) => const AppLayoutScreenTablet(),
            webLayout: (context) => const AppLayoutScreenTablet(),
          ),
        );
      },
    );
  }
}
