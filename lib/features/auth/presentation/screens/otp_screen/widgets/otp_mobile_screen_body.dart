import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:coubot/features/auth/presentation/screens/otp_screen/widgets/pin_code_custom_widget.dart';
import 'package:coubot/features/auth/presentation/screens/otp_screen/widgets/time_row.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// OTPMobileScreenBody is used to manage the package details view
class OTPMobileScreenBody extends StatefulWidget {
  /// OTPMobileScreenBody constructor
  const OTPMobileScreenBody({
    required this.otpType,
    required this.emailToVerify,
    super.key,
  });

  /// [otp type]
  final OtpType otpType;

  /// [email to verify]
  final String emailToVerify;

  @override
  State<OTPMobileScreenBody> createState() => _OTPMobileScreenBodyState();
}

class _OTPMobileScreenBodyState extends State<OTPMobileScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<AuthActionsCubit>().checkOtpFilled(
      context.read<OtpCubit>().otpController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.fw),
      child: Column(
        children: [
          SizedBox(height: 33.fh),
          Text(
            S.of(context).enterTheEmailCode,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
          ),
          SizedBox(height: 10.fh),
          Text(
            S.of(context).weveSendACodeToYourEmailnPleaseEnterCode,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(),
          ),
          if (widget.otpType == OtpType.recovery) SizedBox(height: 20.fh),
          if (widget.otpType == OtpType.recovery)
            Text(
              'context.read<RecognitionCubit>().recognizeController.text',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(),
            ),
          SizedBox(height: 30.fh),
          const PinCodeCustomWidget(),
          SizedBox(height: 35.fh),
          TimerRow(
            otpType: widget.otpType,
            emailToVerify: widget.emailToVerify,
          ),
          SizedBox(height: 35.fh),
        ],
      ),
    );
  }
}
