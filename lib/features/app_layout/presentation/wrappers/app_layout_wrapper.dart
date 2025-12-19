import 'package:auto_route/auto_route.dart';
import 'package:coubot/features/app_layout/presentation/cubit/app_layout/app_layout_cubit.dart';
import 'package:coubot/features/auth/presentation/cubits/auth_actions_cubit/auth_actions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
/// AppLayoutWrapper is used to manage the app layout
class AppLayoutWrapper extends StatelessWidget {
  /// AppLayoutWrapper constructor
  const AppLayoutWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppLayoutCubit()..getAppVersion()),
        BlocProvider(create: (context) => AuthActionsCubit()),
        ],
      child: const AutoRouter(),
    );
  }
}
