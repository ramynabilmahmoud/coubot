import 'dart:developer';

import 'package:coubot/core/utils/snack_x.dart';
import 'package:coubot/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:coubot/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'otp_state.dart';

/// OtpCubit class is a cubit class that is responsible
/// for managing the otp state.
class OtpCubit extends Cubit<OtpState> {
  /// OtpCubit constructor
  OtpCubit({required this.resendOTPUsecase, required this.verifyOtpUsecase})
    : super(OtpInitial());

  /// send sign up otp usecase
  final ResendOTPUsecase resendOTPUsecase;

  /// verify otp usecase
  final VerifyOTPUsecase verifyOtpUsecase;

  /// otp controller
  TextEditingController otpController = TextEditingController();

  /// send signup otp
  Future<void> resendOTP({
    required OtpType otpType,
    required String email,
  }) async {
    emit(ResendOTPLoading());
    final result = await resendOTPUsecase(
      ResendOTPParams(otpType: otpType, email: email),
    );

    result.fold(
      (failure) {
        log(failure.errMessage);
        emit(ResendOTPError(errorMessage: failure.errMessage));
      },
      (isSent) {
        emit(ResendOTPSuccess());
      },
    );
  }

  /// verify otp
  Future<void> verifyOTP({
    required OtpType otpType,
    required String email,
    required String otp,
  }) async {
    emit(VerifyOTPLoading());
    final result = await verifyOtpUsecase(
      VerifyOTPParams(otpType: otpType, email: email, otp: otp),
    );

    result.fold(
      (failure) {
        emit(VerifyOTPError(errorMessage: failure.errMessage));
      },
      (user) {
        emit(VerifyOTPSuccess(authResponse: user));
      },
    );
  }

  /// verifyOTPListener is used to manage listener of verify otp
  void verifyOTPListener({
    required BuildContext context,
    required OtpType otpType,
    required OtpState state,
  }) {
    if (state is VerifyOTPLoading) {
      // Loading.instance().show(
      //   context: context,
      //   text: S.of(context).justWaitASecond,
      // );
    }
    if (state is VerifyOTPSuccess) {
      //Loading.instance().hide();
      if (otpType == OtpType.recovery) {
        // context.router.replace(const ChangePasswordRoute());
      }
      if (otpType == OtpType.signup) {
        appRouter.removeLast();
      }

      if (otpType == OtpType.emailChange) {
        SnackX.showSnackBar(
          message: S.of(context).emailHasBeenUpdatedSuccessfully,
          context: context,
        );
        appRouter
          ..back()
          ..back()
          ..back();
      }
    }
    if (state is VerifyOTPError) {
      // Loading.instance().hide();
      SnackX.showSnackBar(message: state.errorMessage, context: context);
    }
  }

  @override
  Future<void> close() {
    otpController.dispose();
    return super.close();
  }
}
