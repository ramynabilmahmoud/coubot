import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFB02030);

  // ── Light palette ─────────────────────────────────────────────────────────
  static const background = Color(0xFFF0E0E0);
  static const surface = Colors.white;
  static const text = Color(0xFF1D1B1E);
  static const mutedText = Color(0xFF6B6B6B);
  static const chipBg = Color(0xFFFFF6F6);

  // ── Dark palette ──────────────────────────────────────────────────────────
  static const backgroundDark = Color(0xFF1A1118);
  static const surfaceDark = Color(0xFF261E24);
  static const textDark = Color(0xFFF2EBF0);
  static const mutedTextDark = Color(0xFFAA9AA8);
  static const chipBgDark = Color(0xFF2E2230);
}

/// Theme-aware color accessors for one-off [TextStyle] literals.
///
/// Prefer `Theme.of(context).textTheme.<style>` when an existing named
/// text style fits, since [AppTheme]/[AppThemeDark] already configure
/// `textTheme` correctly per brightness. Use these getters only when a
/// literal [TextStyle] needs an explicit color.
extension ThemeColorX on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  /// Primary text color for the current theme brightness.
  Color get textColor => _isDark ? AppColors.textDark : AppColors.text;

  /// Muted/secondary text color for the current theme brightness.
  Color get mutedTextColor =>
      _isDark ? AppColors.mutedTextDark : AppColors.mutedText;
}