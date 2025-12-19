part of 'auth_actions_cubit.dart';

/// AuthStatus is used to manage the authentication status
enum AuthStatus {
  /// unknown status
  unknown,

  /// authenticated status
  authenticated,

  /// unauthenticated status
  unauthenticated,
}

/// AuthState is used to manage the authentication state
class AuthActionsState {
  /// AuthState constructor
  const AuthActionsState({
    this.authResponse,
    this.isRecognizedFilled = false,
    this.isFirstNameFilled = false,
    this.isSecondNameFilled = false,
    this.isSetPasswordFilled = false,
    this.isOtpFilled = false,
    this.isNewPasswordFilled = false,
    this.isConfirmPasswordFilled = false,
    this.showSetPassword = false,
    this.isChangeEmailFilled = false,
    this.isFirstAdditionalNameFilled = false,
    this.isSecondAdditionalNameFilled = false,

    /// example of user
    this.user = const UserEntity(
      name: 'John Doe',
    ),
  });

  /// isRecognizedFilled
  final bool isRecognizedFilled;

  /// isFirstNameFilled
  final bool isFirstNameFilled;

  /// isSecondNameFilled
  final bool isSecondNameFilled;

  /// final User user
  final UserEntity user;

  ///
  final bool isSetPasswordFilled;

  /// bool showSetPassword
  final bool showSetPassword;

  /// is otp filled
  final bool isOtpFilled;

  /// checkNewPasswordFilled
  final bool isNewPasswordFilled;

  /// checkConfirmPasswordFilled
  final bool isConfirmPasswordFilled;

  /// checkChangeEmailFilled
  final bool isChangeEmailFilled;

  /// isFirstAdditionalNameFilled
  final bool isFirstAdditionalNameFilled;

  /// isSecondAdditionalNameFilled
  final bool isSecondAdditionalNameFilled;

  /// Auth response
  final AuthResponse? authResponse;

  /// copyWith
  AuthActionsState copyWith({
    bool? isRecognizedFilled,
    bool? isFirstNameFilled,
    bool? isSecondNameFilled,
    bool? showSetPassword,
    bool? isSetPasswordFilled,
    bool? isNewPasswordFilled,
    bool? isConfirmPasswordFilled,
    AuthResponse? authResponse,
    UserEntity? user,
    String? errMessage,
    bool? isOtpFilled,
    bool? isChangeEmailFilled,
    bool? isFirstAdditionalNameFilled,
    bool? isSecondAdditionalNameFilled,
  }) {
    return AuthActionsState(
      isRecognizedFilled: isRecognizedFilled ?? this.isRecognizedFilled,
      isFirstNameFilled: isFirstNameFilled ?? this.isFirstNameFilled,
      isSecondNameFilled: isSecondNameFilled ?? this.isSecondNameFilled,
      showSetPassword: showSetPassword ?? this.showSetPassword,
      isSetPasswordFilled: isSetPasswordFilled ?? this.isSetPasswordFilled,
      authResponse: authResponse ?? this.authResponse,
      user: user ?? this.user,
      isOtpFilled: isOtpFilled ?? this.isOtpFilled,
      isNewPasswordFilled: isNewPasswordFilled ?? this.isNewPasswordFilled,
      isConfirmPasswordFilled:
          isConfirmPasswordFilled ?? this.isConfirmPasswordFilled,
      isChangeEmailFilled: isChangeEmailFilled ?? this.isChangeEmailFilled,
      isFirstAdditionalNameFilled:
          isFirstAdditionalNameFilled ?? this.isFirstAdditionalNameFilled,
      isSecondAdditionalNameFilled:
          isSecondAdditionalNameFilled ?? this.isSecondAdditionalNameFilled,
    );
  }
}
