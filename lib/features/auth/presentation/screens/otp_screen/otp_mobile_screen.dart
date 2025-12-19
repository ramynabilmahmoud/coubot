import 'package:coubot/features/auth/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:coubot/features/auth/presentation/screens/otp_screen/widgets/otp_mobile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// OtpMobileScreen is used to manage the package details view
class OTPMobileScreen extends StatelessWidget {
  /// OtpMobileScreen constructor
  const OTPMobileScreen({
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
    return BlocProvider(
      create: (context) => TimerCubit()..startTimer(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Expanded(
          child: OTPMobileScreenBody(
            otpType: otpType,
            emailToVerify: emailToVerify,
          ),
        ),
      ),
    );
  }
}
