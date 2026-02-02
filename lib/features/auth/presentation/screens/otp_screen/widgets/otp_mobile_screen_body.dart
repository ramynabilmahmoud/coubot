import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:coubot/features/auth/presentation/screens/otp_screen/widgets/pin_code_custom_widget.dart';
import 'package:coubot/features/auth/presentation/screens/otp_screen/widgets/time_row.dart';
import 'package:coubot/features/auth/presentation/widgets/auth_main_button.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// OTPMobileScreenBody is used to manage the OTP UI
class OTPMobileScreenBody extends StatefulWidget {
  const OTPMobileScreenBody({
    required this.otpType,
    required this.emailToVerify,
    super.key,
  });

  final OtpType otpType;
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
    final otpCubit = context.read<OtpCubit>();

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        // ✅ Use your existing listener for verify flow
        otpCubit.verifyOTPListener(
          context: context,
          otpType: widget.otpType,
          state: state,
        );

        // ✅ Handle resend feedback here (your verifyOTPListener doesn't)
        if (state is ResendOTPError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }

        if (state is ResendOTPSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).codeSent)),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFF1F1),
        body: Stack(
          children: [
            /// RED TOP SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: const BoxDecoration(
                color: Color(0xFFC72C41),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(55)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/gen/images/logo_horizontal.png',
                      height: 60,
                    ),
                    const SizedBox(height: 28),

                    Text(
                      S.of(context).enterTheEmailCode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      S.of(context).weveSendACodeToYourEmailnPleaseEnterCode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// OTP INPUT
                    const PinCodeCustomWidget(),

                    const SizedBox(height: 20),

                    /// ✅ CONFIRM BUTTON
                    BlocBuilder<AuthActionsCubit, AuthActionsState>(
                      builder: (context, aState) {
                        return BlocBuilder<OtpCubit, OtpState>(
                          builder: (context, oState) {
                            final isVerifyLoading = oState is VerifyOTPLoading;
                            final canSubmit = aState.isOtpFilled && !isVerifyLoading;

                            return AuthMainButton(
                              text: isVerifyLoading
                                  ? S.of(context).justWaitASecond
                                  : S.of(context).confirm,
                              onPressed: canSubmit
                                  ? () {
                                      otpCubit.verifyOTP(
                                        otpType: widget.otpType,
                                        email: widget.emailToVerify,
                                        otp: otpCubit.otpController.text.trim(),
                                      );
                                    }
                                  : null,
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    /// ✅ RESEND BUTTON
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        final isResendLoading = state is ResendOTPLoading;

                        return TextButton(
                          onPressed: isResendLoading
                              ? null
                              : () {
                                  otpCubit.resendOTP(
                                    otpType: widget.otpType,
                                    email: widget.emailToVerify,
                                  );
                                },
                          child: Text(
                            isResendLoading
                                ? S.of(context).justWaitASecond
                                : S.of(context).resendCode,
                            style: TextStyle(
                              fontFamily: 'MadeEvolveSans',
                              fontSize: 14,
                              color: isResendLoading ? Colors.white54 : Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// BACK BUTTON
            SafeArea(
              child: IconButton(
                icon: Image.asset(
                  'assets/gen/images/chevron_backward.png',
                  height: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            /// TIMER ROW (your existing one)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TimerRow(
                  otpType: widget.otpType,
                  emailToVerify: widget.emailToVerify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
