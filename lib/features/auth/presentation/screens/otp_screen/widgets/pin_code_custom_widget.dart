import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

/// PinCodeCustomWidget is used to manage the package details view
class PinCodeCustomWidget extends StatelessWidget {
  /// PinCodeCustomWidget constructor
  const PinCodeCustomWidget({super.key});

  ///   defaultPinTheme

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.fw,
      height: 70.fh,
      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(),
      ),
    );
    return Pinput(
      controller: context.read<OtpCubit>().otpController,
      length: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        context.read<AuthActionsCubit>().checkOtpFilled(value);
      },
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme,
      submittedPinTheme: defaultPinTheme,
    );
  }
}
