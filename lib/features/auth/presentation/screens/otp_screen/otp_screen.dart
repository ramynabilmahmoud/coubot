import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/presentation/widgets/adaptive_layout.dart';
import 'package:coubot/features/auth/presentation/screens/otp_screen/otp_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// OTPScreen is used to manage the package details view
@RoutePage()
class OTPScreen extends StatelessWidget {
  /// OTPScreen constructor
  const OTPScreen({
    required this.otpType,
    required this.emailToVerify,
    super.key,
  });

  /// [otp type]
  final OtpType otpType;

  /// [email to verify]
  final String emailToVerify;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) =>
          OTPMobileScreen(otpType: otpType, emailToVerify: emailToVerify),
      tabletLayout: (context) =>
          OTPMobileScreen(otpType: otpType, emailToVerify: emailToVerify),
      webLayout: (context) =>
          OTPMobileScreen(otpType: otpType, emailToVerify: emailToVerify),
    );
  }
}
