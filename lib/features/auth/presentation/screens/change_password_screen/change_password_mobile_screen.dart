import 'package:coubot/features/auth/presentation/screens/change_password_screen/widgets/change_password_mobile_screen_body.dart';
import 'package:flutter/material.dart';

/// ChangePasswordMobileScreen is used to manage the package details view
class ChangePasswordMobileScreen extends StatelessWidget {
  /// ChangePasswordMobileScreen constructor
  const ChangePasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Expanded(child: ChangePasswordMobileScreenBody()),
    );
  }
}
