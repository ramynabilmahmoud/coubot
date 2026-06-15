import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/core/utils/app_strings.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/features/app_splash/presentation/cubit/main/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).settings,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final cubit = MainCubit.get(context);
          final isDark = cubit.currentThemeMode == ThemeMode.dark;
          final isArabic = cubit.currentLangCode == AppStrings.arabicCode;
          final notificationsEnabled = cubit.currentNotificationsEnabled;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _SectionLabel(label: S.of(context).appearance),
              _SettingsTile(
                icon: isDark ? Icons.dark_mode : Icons.light_mode_outlined,
                label: S.of(context).darkMode,
                trailing: Switch.adaptive(
                  value: isDark,
                  activeTrackColor: AppColors.primary,
                  onChanged: (val) => cubit.changeTheme(
                    themeMode: val ? ThemeMode.dark.name : ThemeMode.light.name,
                    context: context,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _SectionLabel(label: S.of(context).language),
              _SettingsTile(
                icon: Icons.language_outlined,
                label: S.of(context).language,
                trailing: _LangToggle(
                  isArabic: isArabic,
                  onToggle: (arabic) => cubit.changeLang(
                    languageValue:
                        arabic ? AppStrings.arabicCode : AppStrings.englishCode,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _SectionLabel(label: S.of(context).notifications),
              _SettingsTile(
                icon: notificationsEnabled
                    ? Icons.notifications_outlined
                    : Icons.notifications_off_outlined,
                label: S.of(context).pushNotifications,
                trailing: Switch.adaptive(
                  value: notificationsEnabled,
                  activeTrackColor: AppColors.primary,
                  onChanged: (val) =>
                      cubit.changeNotifications(enabled: val),
                ),
              ),

              const SizedBox(height: 20),
              _SectionLabel(label: S.of(context).about),
              _SettingsTile(
                icon: Icons.info_outline,
                label: S.of(context).appVersion,
                trailing: Text(
                  '0.1.0',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Section label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

// ── Settings tile ────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        elevation: 1,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Language toggle ──────────────────────────────────────────────────────────

class _LangToggle extends StatelessWidget {
  final bool isArabic;
  final ValueChanged<bool> onToggle;

  const _LangToggle({required this.isArabic, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LangChip(
            label: 'EN',
            selected: !isArabic,
            onTap: () => onToggle(false),
          ),
          _LangChip(
            label: 'AR',
            selected: isArabic,
            onTap: () => onToggle(true),
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
      ),
    );
  }
}
