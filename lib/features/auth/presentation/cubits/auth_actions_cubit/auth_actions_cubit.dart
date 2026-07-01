import 'package:coubot/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_actions_state.dart';

/// AuthActionsCubit is used to manage the authentication state
class AuthActionsCubit extends Cubit<AuthActionsState> {
  /// AuthActionsCubit constructor
  AuthActionsCubit() : super(const AuthActionsState());

  /// checkEmailFilled
  void checkEmailFilled(String email) {
    emit(
      state.copyWith(
        isEmailFilled:
            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
            email.isNotEmpty,
      ),
    );
  }

  /// check user name (letters + spaces)
  void checkNameFilled(String name) {
    final trimmed = name.trim();

    final isValid =
        RegExp(r'^[a-zA-Z]+(?:\s+[a-zA-Z]+)*$').hasMatch(trimmed) &&
        trimmed.replaceAll(' ', '').length >= 2;

    emit(state.copyWith(isUserNameFilled: isValid));
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
  // void checkChangeEmailFilled(String email) {
  //   emit(
  //     state.copyWith(
  //       isChangeEmailFilled:
  //           RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
  //           email.isNotEmpty,
  //     ),
  //   );
  // }
}
