import 'package:coubot/features/app_layout/presentation/cubits/app_layout_cubit.dart';
import 'package:coubot/features/app_splash/presentation/cubit/main/main_cubit.dart';
import 'package:coubot/features/home/presentation/screens/home_screen.dart';
import 'package:coubot/features/orders/presentation/screens/orders_screen.dart';
import 'package:coubot/features/profile/presentation/screens/profile_screen.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AppLayoutScreen is used to manage the app layout
class AppLayoutScreen extends StatelessWidget {
  /// AppLayoutScreen constructor
  const AppLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLayoutCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, _) {
          return BlocBuilder<AppLayoutCubit, AppLayoutState>(
            builder: (context, state) {
              return Scaffold(
                body: _buildBody(state.selectedTab),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.selectedTab,
                  onTap: (index) {
                    context.read<AppLayoutCubit>().selectTab(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  elevation: 8,
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.home_rounded),
                      label: S.of(context).home,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.shopping_bag_rounded),
                      label: S.of(context).orders,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.person_rounded),
                      label: S.of(context).profile,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const HomeScreen();
      case 1:
        return const OrdersScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}
