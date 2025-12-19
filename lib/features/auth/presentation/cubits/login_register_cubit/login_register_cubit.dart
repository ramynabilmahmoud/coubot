import 'package:coubot/core/utils/snack_x.dart';
import 'package:coubot/core/utils/validation_helper.dart';
import 'package:coubot/features/auth/domain/usecases/sign_in_with_email_password_usecase.dart';
import 'package:coubot/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_register_state.dart';

/// LoginCubit class is a cubit class that is responsible
/// for managing the login state.
class LoginAndRegisterCubit extends Cubit<LoginAndRegisterState> {
  /// LoginCubit constructor
  LoginAndRegisterCubit({
    required this.signInWithEndPUseCase,
    required this.signUpUsecase,
  }) : super(LoginInitial());

  /// usecase
  final SignInWithEmailPasswordUsecase signInWithEndPUseCase;

  /// signUpUsecase
  final SignUpUsecase signUpUsecase;

  /// firstNameController
  TextEditingController firstNameController = TextEditingController();

  /// secondNameController
  TextEditingController secondNameController = TextEditingController();

  /// set password controller
  TextEditingController setPasswordController = TextEditingController();

  /// set password controller
  Future<void> signInWithEmailAndPassword({required String email}) async {
    emit(LoginLoading());
    final result = await signInWithEndPUseCase(
      SignInParams(email: email, password: setPasswordController.text),
    );
    result.fold(
      (failure) {
        emit(LoginError(errorMessage: failure.errMessage));
      },
      (user) {
        emit(LoginSuccess(authResponse: user));
      },
    );
  }

  /// signup with email and password and first and second name
  Future<void> signUp({required String email}) async {
    emit(RegisterLoading());
    final result = await signUpUsecase(
      SignUpParams(
        lastName: secondNameController.text,
        email: email,
        firstName: firstNameController.text,
        password: setPasswordController.text,
      ),
    );
    result.fold(
      (failure) {
        emit(RegisterError(errorMessage: failure.errMessage));
      },
      (user) {
        emit(RegisterSuccess(authResponse: user));
      },
    );
  }

  /// login and register listener
  void loginAndRegisterListener(
    LoginAndRegisterState state,
    BuildContext context,
  ) {
    if (state is LoginLoading || state is RegisterLoading) {
      // Loading.instance().show(
      //   context: context,
      //   text: S.of(context).justWaitASecond,
      // );
    }

    if (state is LoginError || state is RegisterError) {
      // Loading.instance().hide();
      SnackX.showSnackBar(
        message: state is LoginError
            ? state.errorMessage
            : state is RegisterError
            ? state.errorMessage
            : '',
        context: context,
      );
    }

    if (state is LoginSuccess) {
      // Loading.instance().hide();
      appRouter.removeLast();
    }

    if (state is RegisterSuccess) {
      //  Loading.instance().hide();
      // context.router.push(
      //   OTPRoute(
      //     otpType: OtpType.signup,
      //     emailToVerify:
      //         context.read<RecognitionCubit>().recognizeController.text,
      //   ),
      // );
    }
  }

  /// setPasswordButtonFunction
  void setPasswordButtonFunction({
    required GlobalKey<FormState> setPasswordFormKey,
    required bool fromLogin,
    required BuildContext context,
  }) {
    if (FormValidator.validateForm(setPasswordFormKey)) {
      if (fromLogin) {
        // context.read<LoginAndRegisterCubit>().signInWithEmailAndPassword(
        //       email: context.read<RecognitionCubit>().recognizeController.text,
        //     );
      } else {
        // context.read<LoginAndRegisterCubit>().signUp(
        //       email: context.read<RecognitionCubit>().recognizeController.text,
        //     );
      }
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    secondNameController.dispose();
    setPasswordController.dispose();
    return super.close();
  }
}
