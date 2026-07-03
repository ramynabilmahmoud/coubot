import 'package:auto_route/auto_route.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/features/app_layout/presentation/cubits/app_layout_cubit.dart';
import 'package:coubot/features/home/presentation/cubits/home_cubit.dart';
import 'package:coubot/features/profile/presentation/screens/favourites_screen.dart';
import 'package:coubot/features/profile/presentation/screens/settings_screen.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = supabaseClient.auth.currentUser;
    final email = user?.email ?? '';
    final meta = user?.userMetadata ?? {};
    final firstName = meta['first_name'] as String? ?? '';
    final lastName = meta['last_name'] as String? ?? '';
    final fullName = [firstName, lastName].where((s) => s.isNotEmpty).join(' ');
    final displayName = fullName.isNotEmpty ? fullName : email.split('@').first;
    final initials = _initials(displayName);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).profile,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 16),

          // Avatar
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary,
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Name
          Center(
            child: Text(
              displayName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Email
          Center(
            child: Text(
              email,
              style: TextStyle(
                fontSize: 13,
                color: context.mutedTextColor,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Action tiles
          _ProfileTile(
            icon: Icons.shopping_bag_outlined,
            label: S.of(context).myOrders,
            onTap: () => context.read<AppLayoutCubit>().selectTab(1),
          ),
          _ProfileTile(
            icon: Icons.favorite_border,
            label: S.of(context).favourites,
            onTap: () {
              final homeCubit = context.read<HomeCubit>();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: homeCubit,
                    child: const FavouritesScreen(),
                  ),
                ),
              );
            },
          ),
          _ProfileTile(
            icon: Icons.settings_outlined,
            label: S.of(context).settings,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          _ProfileTile(
            icon: Icons.logout,
            label: S.of(context).logOut,
            iconColor: AppColors.primary,
            labelColor: AppColors.primary,
            onTap: () async {
              await supabaseClient.auth.signOut();
              if (context.mounted) {
                context.router.replaceAll([const AuthWrapper()]);
              }
            },
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    if (name.isNotEmpty) return name[0].toUpperCase();
    return '?';
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        elevation: 1,
        shadowColor: Colors.black12,
        child: ListTile(
          leading: Icon(icon, color: iconColor ?? cs.onSurface),
          title: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: labelColor ?? cs.onSurface,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: cs.onSurface.withValues(alpha: 0.4)),
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
