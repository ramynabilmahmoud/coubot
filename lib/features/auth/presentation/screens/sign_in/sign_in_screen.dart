import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/presentation/widgets/adaptive_layout.dart';
import 'package:coubot/features/auth/presentation/screens/sign_in/sign_in_mobile_screen.dart';
import 'package:flutter/material.dart';

/// OTPScreen is used to manage the package details view
@RoutePage()
class SignInScreen extends StatelessWidget {
  /// SignInScreen constructor
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => SignInMobileScreen(),
      tabletLayout: (context) => SignInMobileScreen(),
      webLayout: (context) => SignInMobileScreen(),
    );
  }
}
