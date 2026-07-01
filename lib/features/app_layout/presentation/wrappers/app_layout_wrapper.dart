import 'package:auto_route/auto_route.dart';
import 'package:coubot/core/injection_container.dart';
import 'package:coubot/features/app_layout/presentation/screens/app_layout_screen.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:coubot/features/home/presentation/cubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AppLayoutWrapper is used to manage the app layout
@RoutePage()
class AppLayoutWrapper extends StatelessWidget {
  /// AppLayoutWrapper constructor
  const AppLayoutWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthActionsCubit()),
        BlocProvider(create: (_) => getIt<HomeCubit>()..load()),
      ],
      child: const AppLayoutScreen(),
    );
  }
}
