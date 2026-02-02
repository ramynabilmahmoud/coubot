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
    this.isUserNameFilled = false,
    this.isEmailFilled = false,
    this.isSetPasswordFilled = false,
    this.isNewPasswordFilled = false,
    this.isConfirmPasswordFilled = false,
    this.showSetPassword = false,
    this.isChangeEmailFilled = false,
    this.isFirstAdditionalNameFilled = false,
    this.isSecondAdditionalNameFilled = false,

    /// example of user
    this.user = const UserEntity(name: 'John Doe'),
  });

  /// isUserNameFilled
  final bool isUserNameFilled;

  /// isEmailFilled
  final bool isEmailFilled;

  // /// isFirstNameFilled
  // final bool isFirstNameFilled;

  // /// isSecondNameFilled
  // final bool isSecondNameFilled;

  /// final User user
  final UserEntity user;

  ///
  final bool isSetPasswordFilled;

  /// bool showSetPassword
  final bool showSetPassword;

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
    bool? isUserNameFilled,
    bool? isEmailFilled,
    bool? showSetPassword,
    bool? isSetPasswordFilled,
    bool? isNewPasswordFilled,
    bool? isConfirmPasswordFilled,
    AuthResponse? authResponse,
    UserEntity? user,
    String? errMessage,
    bool? isChangeEmailFilled,
    bool? isFirstAdditionalNameFilled,
    bool? isSecondAdditionalNameFilled,
  }) {
    return AuthActionsState(
      isUserNameFilled: isUserNameFilled ?? this.isUserNameFilled,
      isEmailFilled: isEmailFilled ?? this.isEmailFilled,
      showSetPassword: showSetPassword ?? this.showSetPassword,
      isSetPasswordFilled: isSetPasswordFilled ?? this.isSetPasswordFilled,
      authResponse: authResponse ?? this.authResponse,
      user: user ?? this.user,
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
