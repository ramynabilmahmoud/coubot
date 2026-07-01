import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/presentation/widgets/adaptive_layout.dart';
import 'package:coubot/features/auth/presentation/screens/sign_up/sign_up_mobile_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  /// SignUpScreen constructor
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => SignUpMobileScreen(),
      tabletLayout: (context) => SignUpMobileScreen(),
      webLayout: (context) => SignUpMobileScreen(),
    );
  }
}
