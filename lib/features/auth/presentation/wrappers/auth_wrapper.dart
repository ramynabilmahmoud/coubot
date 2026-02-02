import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/injection_container.dart';
import 'package:coubot/features/auth/domain/usecases/sign_in_with_email_password_usecase.dart';
import 'package:coubot/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/login_register_cubit/login_register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
/// AuthWrapper is used to manage the app layout
class AuthWrapper extends StatelessWidget {
  /// AuthWrapper constructor
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthActionsCubit()),
        BlocProvider(
          create: (context) => LoginAndRegisterCubit(
            signInWithEndPUseCase: getIt<SignInWithEmailPasswordUsecase>(),
            signUpUsecase: getIt<SignUpUsecase>(),
          ),
        ),
      ],
      child: const AutoRouter(),
    );
  }
}
