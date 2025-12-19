import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:coubot/core/utils/app_colors.dart';
import 'package:coubot/core/utils/snack_x.dart';
import 'package:coubot/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// [TimerRow]
class TimerRow extends StatelessWidget {
  /// [TimerRow] constructor
  const TimerRow({
    required this.otpType,
    required this.emailToVerify,
    super.key,
  });

  /// [otpType]
  final supabase.OtpType otpType;

  /// [emailToVerify]
  final String emailToVerify;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is ResendOTPSuccess) {
          context.read<TimerCubit>().startTimer();
        }
        if (state is ResendOTPError) {
          context.read<TimerCubit>().resetTimer();

          SnackX.showSnackBar(message: state.errorMessage, context: context);
        }
      },
      child: BlocBuilder<TimerCubit, int>(
        builder: (context, state) {
          final seconds = (state % 60).toString().padLeft(2, '0');
          return InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: state == 0
                ? () {
                    if (otpType == supabase.OtpType.recovery) {
                      context.read<ForgetPasswordCubit>().resetPasswordForEmail(
                        emailToVerify,
                      );
                    } else if (otpType == supabase.OtpType.emailChange) {
                      context.read<OtpCubit>().resendOTP(
                        email: supabaseClient.auth.currentUser!.email!,
                        otpType: otpType,
                      );
                    } else {
                      context.read<OtpCubit>().resendOTP(
                        email: emailToVerify,
                        otpType: otpType,
                      );
                    }
                  }
                : null,
            child: Column(
              children: [
                if (state == 0)
                  Icon(Icons.refresh, color: AppColors.primary, size: 18.sp)
                else
                  SizedBox(
                    height: 18.sp,
                    child: Text(
                      '${seconds}s',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(fontSize: 10.sp, color: AppColors.primary),
                    ),
                  ),
                SizedBox(height: 6.fh),
                Text(
                  state == 0 ? S.of(context).sendAgain : S.of(context).wait,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                 //  color: AppColors.aquaDeep,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
