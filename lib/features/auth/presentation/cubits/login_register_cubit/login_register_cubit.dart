import 'dart:developer';

import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/features/auth/domain/usecases/sign_in_with_email_password_usecase.dart';
import 'package:coubot/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_register_state.dart';

/// LoginCubit class is a cubit class that is responsible
class LoginAndRegisterCubit extends Cubit<LoginAndRegisterState> {
  LoginAndRegisterCubit({
    required this.signInWithEndPUseCase,
    required this.signUpUsecase,
  }) : super(LoginInitial());

  final SignInWithEmailPasswordUsecase signInWithEndPUseCase;
  final SignUpUsecase signUpUsecase;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController setPasswordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    emit(LoginLoading());
    final result = await signInWithEndPUseCase(
      SignInParams(
        email: emailController.text.trim(),
        password: setPasswordController.text,
      ),
    );

    result.fold(
      (failure) => emit(LoginError(errorMessage: failure.errMessage)),
      (user) {
        log('Login success: ${user.user?.email}');
        emit(LoginSuccess(authResponse: user));
        // Navigate to app layout
        appRouter.replaceAll([const AppLayoutWrapper()]);
      }
    );
  }

  Future<void> signUp() async {
    emit(RegisterLoading());
    final result = await signUpUsecase(
      SignUpParams(
        lastName: secondNameController.text,
        email: emailController.text.trim(),
        firstName: firstNameController.text,
        password: setPasswordController.text,
      ),
    );

    result.fold(
      (failure) => emit(RegisterError(errorMessage: failure.errMessage)),
      (user) {
        log('Register success: ${user.user?.email}');
        emit(RegisterSuccess(authResponse: user));
        // Navigate to app layout
        appRouter.replaceAll([const AppLayoutWrapper()]);
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    firstNameController.dispose();
    secondNameController.dispose();
    setPasswordController.dispose();
    return super.close();
  }
}
