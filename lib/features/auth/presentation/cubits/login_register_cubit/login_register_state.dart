part of 'login_register_cubit.dart';

/// LoginAndRegisterState class
sealed class LoginAndRegisterState {
  const LoginAndRegisterState();
}

/// LoginInitial state
final class LoginInitial extends LoginAndRegisterState {}

/// LoginLoading state
final class LoginLoading extends LoginAndRegisterState {}

/// LoginError state
final class LoginError extends LoginAndRegisterState {
  /// LoginError constructor
  const LoginError({
    required this.errorMessage,
  });

  /// error message
  final String errorMessage;
}

/// LoginSuccess state
final class LoginSuccess extends LoginAndRegisterState {
  /// LoginSuccess constructor
  const LoginSuccess({
    required this.authResponse,
  });

  /// auth response
  final AuthResponse authResponse;
}

/// RegisterLoading state
final class RegisterLoading extends LoginAndRegisterState {}

/// RegisterError state
final class RegisterError extends LoginAndRegisterState {
  /// RegisterError constructor
  const RegisterError({
    required this.errorMessage,
  });

  /// error message
  final String errorMessage;
}

/// RegisterSuccess state
final class RegisterSuccess extends LoginAndRegisterState {
  /// RegisterSuccess constructor
  const RegisterSuccess({
    required this.authResponse,
  });

  /// auth response
  final AuthResponse authResponse;
}
