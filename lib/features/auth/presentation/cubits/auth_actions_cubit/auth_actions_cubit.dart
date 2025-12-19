import 'package:coubot/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_actions_state.dart';

/// AuthActionsCubit is used to manage the authentication state
class AuthActionsCubit extends Cubit<AuthActionsState> {
  /// AuthActionsCubit constructor
  AuthActionsCubit() : super(const AuthActionsState());

  /// checkRecognizedFilled
  void checkRecognizedFilled(String email) {
    emit(
      state.copyWith(
        isRecognizedFilled:
            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
            email.isNotEmpty,
      ),
    );
  }

  ///check first and second name with regex
  void checkFirstNameFilled(String name) {
    emit(
      state.copyWith(
        isFirstNameFilled:
            RegExp(r'^[a-zA-Z]{2,}$').hasMatch(name) && name.isNotEmpty,
      ),
    );
  }

  /// checkSecondNameFilled
  void checkSecondNameFilled(String name) {
    emit(
      state.copyWith(
        isSecondNameFilled:
            RegExp(r'^[a-zA-Z]{2,}$').hasMatch(name) && name.isNotEmpty,
      ),
    );
  }

  /// checkSetPasswordFilled
  void checkSetPasswordFilled(String password) {
    emit(
      state.copyWith(
        isSetPasswordFilled: password.isNotEmpty && password.length >= 6,
      ),
    );
  }

  /// Reset form state
  void resetFormState() {
    emit(state.copyWith(isSetPasswordFilled: false));
  }

  /// checkOtpFilled
  void checkOtpFilled(String otp) {
    emit(state.copyWith(isOtpFilled: otp.isNotEmpty && otp.length == 6));
  }

  /// checkNewPasswordFilled
  void checkNewPasswordFilled(String password) {
    emit(
      state.copyWith(
        isNewPasswordFilled: password.isNotEmpty && password.length >= 6,
      ),
    );
  }

  /// checkConfirmPasswordFilled
  void checkConfirmPasswordFilled(String password) {
    emit(
      state.copyWith(
        isConfirmPasswordFilled: password.isNotEmpty && password.length >= 6,
      ),
    );
  }

  /// toggleShowSetPassword
  void toggleShowSetPassword() {
    emit(state.copyWith(showSetPassword: !state.showSetPassword));
  }

  /// checkChangeEmailFilled
  void checkChangeEmailFilled(String email) {
    emit(
      state.copyWith(
        isChangeEmailFilled:
            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
            email.isNotEmpty,
      ),
    );
  }

  /// checkFirstAdditionalNameFilled
  void checkFirstAdditionalNameFilled(String name) {
    emit(
      state.copyWith(
        isFirstAdditionalNameFilled:
            RegExp(r'^[a-zA-Z]{2,}$').hasMatch(name.trim()) && name.isNotEmpty,
      ),
    );
  }

  /// checkSecondAdditionalNameFilled
  void checkSecondAdditionalNameFilled(String name) {
    emit(
      state.copyWith(
        isSecondAdditionalNameFilled:
            RegExp(r'^[a-zA-Z]{2,}$').hasMatch(name.trim()) && name.isNotEmpty,
      ),
    );
  }
}
