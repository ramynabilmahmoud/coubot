import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/utils/snack_x.dart';
import 'package:coubot/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:coubot/features/auth/domain/usecases/update_user_password_usecase.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

/// ForgetPasswordCubit is used to manage the forget password state
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  /// ForgetPasswordCubit constructor
  ForgetPasswordCubit({
    required this.forgetPasswordUsecase,
    required this.updatePasswordUsecase,
  }) : super(ForgetPasswordInitial());

  /// forgetPasswordUsecase
  final ForgetPasswordUsecase forgetPasswordUsecase;

  /// [updatePasswordUsecase]
  final UpdateUserPasswordUsecase updatePasswordUsecase;

  /// [newPasswordController]
  final newPasswordController = TextEditingController();

  /// [confirmPasswordController]
  final confirmPasswordController = TextEditingController();

  /// forget password [resetPasswordForEmail]
  Future<void> resetPasswordForEmail(String email) async {
    emit(ResetPasswordLoading());
    final result = await forgetPasswordUsecase(
      ForgetPasswordParams(email: email),
    );
    result.fold(
      (l) {
        emit(ResetPasswordError(errMessage: l.errMessage));
      },
      (r) {
        emit(ResetPasswordSuccess());
      },
    );
  }

  /// [updatePassword]
  Future<void> updatePassword() async {
    emit(UpdatePasswordLoading());
    final result = await updatePasswordUsecase(
      UpdateUserPasswordParams(password: newPasswordController.text),
    );
    result.fold(
      (l) {
        emit(UpdatePasswordError(errMessage: l.errMessage));
      },
      (r) {
        emit(UpdatePasswordSuccess());
      },
    );
  }

  /// [initChangePassMethod]
  void initChangePassMethod({required BuildContext context}) {
    context.read<ForgetPasswordCubit>().newPasswordController.text = '';
    context.read<ForgetPasswordCubit>().confirmPasswordController.text = '';
    context.read<AuthActionsCubit>().checkNewPasswordFilled('');
    context.read<AuthActionsCubit>().checkConfirmPasswordFilled('');
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  /// forget password listener
  void forgetPasswordListener({
    required ForgetPasswordState state,
    required BuildContext context,
  }) {
    if (state is UpdatePasswordLoading) {
      // Loading.instance().show(
      //   context: context,
      //   text: S.of(context).justWaitASecond,
      // );
    }
    if (state is UpdatePasswordSuccess) {
      // Loading.instance().hide();
      context.router.maybePop();
    }
    if (state is UpdatePasswordError) {
      // Loading.instance().hide();

      SnackX.showSnackBar(message: state.errMessage, context: context);
    }
  }

  /// reset password listener
  void resetPasswordListener({
    required ForgetPasswordState state,
    required BuildContext context,
  }) {
    if (state is ResetPasswordSuccess) {
      //Loading.instance().hide();
      // context.router.push(
      //   OTPRoute(
      //     otpType: OtpType.recovery,
      //     emailToVerify:
      //         context.read<RecognitionCubit>().recognizeController.text,
      //   ),
      // );
    }

    if (state is ResetPasswordError) {
      //Loading.instance().hide();

      /// show snack bar
      SnackX.showSnackBar(message: state.errMessage, context: context);
    }
    if (state is ResetPasswordLoading) {
      // Loading.instance().show(
      //   context: context,
      //   text: S.of(context).justWaitASecond,
      // );
    }
  }
}
