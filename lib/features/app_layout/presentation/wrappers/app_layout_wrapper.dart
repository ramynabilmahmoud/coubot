import 'package:coubot/features/app_layout/presentation/cubits/app_layout_cubit.dart';
import 'package:coubot/features/app_layout/presentation/screens/app_layout_screen.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AppLayoutWrapper is used to manage the app layout
class AppLayoutWrapper extends StatelessWidget {
  /// AppLayoutWrapper constructor
  const AppLayoutWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppLayoutCubit()),
        BlocProvider(create: (context) => AuthActionsCubit()),
      ],
      child: const AppLayoutScreen(),
    );
  }
}
