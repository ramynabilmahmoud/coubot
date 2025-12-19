part of 'otp_cubit.dart';

/// OtpState class
sealed class OtpState {
  const OtpState();
}

/// OtpInitial state
final class OtpInitial extends OtpState {}

/// ResendOTPLoading state
final class ResendOTPLoading extends OtpState {}

/// ResendOTPError state
final class ResendOTPError extends OtpState {
  /// ResendOTPError constructor
  const ResendOTPError({
    required this.errorMessage,
  });

  /// error message
  final String errorMessage;
}

/// ResendOTPSuccess state
final class ResendOTPSuccess extends OtpState {}

/// VerifyOTPLoading state
final class VerifyOTPLoading extends OtpState {}

/// VerifyOTPError state
final class VerifyOTPError extends OtpState {
  /// VerifyOTPError constructor
  const VerifyOTPError({
    required this.errorMessage,
  });

  /// error message
  final String errorMessage;
}

/// VerifyOTPSuccess state
final class VerifyOTPSuccess extends OtpState {
  /// VerifyOTPSuccess constructor
  const VerifyOTPSuccess({
    required this.authResponse,
  });

  /// auth response
  final AuthResponse authResponse;
}
