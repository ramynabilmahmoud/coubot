part of 'forget_password_cubit.dart';

/// ForgetPassword State
sealed class ForgetPasswordState {
  /// ForgetPassword State constructor
  const ForgetPasswordState();
}

/// ForgetPasswordInitial state
final class ForgetPasswordInitial extends ForgetPasswordState {}

/// reset password loading state
final class ResetPasswordLoading extends ForgetPasswordState {}

/// reset password success state
final class ResetPasswordSuccess extends ForgetPasswordState {}

/// reset password error state
final class ResetPasswordError extends ForgetPasswordState {
  /// ResetPasswordError constructor
  const ResetPasswordError({
    required this.errMessage,
  });

  /// error message
  final String errMessage;
}

/// update password loading state
final class UpdatePasswordLoading extends ForgetPasswordState {}

/// update password success state
final class UpdatePasswordSuccess extends ForgetPasswordState {}

/// update password error state
final class UpdatePasswordError extends ForgetPasswordState {
  /// UpdatePasswordError constructor
  const UpdatePasswordError({
    required this.errMessage,
  });

  /// error message
  final String errMessage;
}
