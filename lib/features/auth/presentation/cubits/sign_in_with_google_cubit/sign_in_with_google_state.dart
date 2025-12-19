part of 'sign_in_with_google_cubit.dart';

/// SignInWithGoogleState
/// is a class that manages the state of the sign in with google process
sealed class SignInWithGoogleState {
  const SignInWithGoogleState();
}

/// SignInWithGoogleInitial is a class that manages
/// the initial state of the sign in with google process
final class SignInWithGoogleInitial extends SignInWithGoogleState {}

/// SignInWithGoogleLoading is a class that manages
/// the loading state of the sign in with google process
final class SignInWithGoogleLoading extends SignInWithGoogleState {}

/// SignInWithGoogleSuccess is a class that manages
/// the success state of the sign in with google process
final class SignInWithGoogleSuccess extends SignInWithGoogleState {
  /// Generative constructor
  const SignInWithGoogleSuccess(this.authResponse);

  /// AuthResponse
  final AuthResponse authResponse;
}

/// SignInWithGoogleError is a class that manages
/// the Error state of the sign in with google process
final class SignInWithGoogleError extends SignInWithGoogleState {
  /// Generative constructor
  const SignInWithGoogleError(this.errMessage);

  /// Error
  final String errMessage;
}
