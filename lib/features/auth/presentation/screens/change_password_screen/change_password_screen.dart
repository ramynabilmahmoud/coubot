import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/presentation/widgets/adaptive_layout.dart';
import 'package:coubot/features/auth/presentation/screens/change_password_screen/change_password_mobile_screen.dart';
import 'package:flutter/material.dart';

/// ChangePasswordScreen is used to manage the package details view
@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  /// ChangePasswordScreen constructor
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const ChangePasswordMobileScreen(),
      tabletLayout: (context) => const ChangePasswordMobileScreen(),
      webLayout: (context) => const ChangePasswordMobileScreen(),
    );
  }
}
