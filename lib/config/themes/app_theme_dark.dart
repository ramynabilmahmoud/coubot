// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// A class that provides a Dark theme configuration for the application.
class AppThemeDark {
  /// Returns a [ThemeData] object representing the Dark theme of the app.
  ///
  /// The `lang` argument specifies the language for which the font family
  /// should be selected.
  ///
  /// The returned theme has its various properties configured, such as
  /// text styles, colors, etc.
  static ThemeData theme({required String lang}) {
    return ThemeData(
      // /// useMaterial3.
      // useMaterial3: true,
      // // Define the primary color swatch.
      // primarySwatch: AppColors.primarySwatchColor,

      // // Select the font family based on the language setting.
      // fontFamily: lang == AppStrings.arabicCode
      //     ? AppStrings.arabicFontFamily
      //     : AppStrings.englishFontFamily,

      // textSelectionTheme: TextSelectionThemeData(
      //   selectionColor: AppColors.disabledPrimary,
      //   selectionHandleColor: AppColors.text,
      //   cursorColor: AppColors.primary,
      // ),

      // // Various color configurations.
      // // Adjust colors for dark theme
      // primaryColor: AppColors.primary, // Define darkPrimary in AppColors
      // hintColor: AppColors.darkGrey.withOpacity(
      //   0.8,
      // ), // More opacity for dark mode
      // disabledColor:
      //     AppColors.disabledPrimary, // Define disabledDark in AppColors
      // dividerColor: AppColors.lightText, // Light text color for dividers
      // focusColor: Colors.transparent,
      // splashColor: Colors.transparent,
      // highlightColor: AppColors.outrageousOrange,
      // hoverColor: Colors.transparent,
      // shadowColor: Colors.transparent,
      // secondaryHeaderColor: AppColors.bottomSheetsAndPopupsDark,
      // cardColor: AppColors.darkCard, // Define darkCard in AppColors
      // scaffoldBackgroundColor:
      //     AppColors.darkBackground, // Define darkBackground in AppColors
      // // Set the brightness level.
      // brightness: Brightness.dark,

      // // // Configure the AppBar theme.
      // // appBarTheme: const AppBarTheme(
      // //   titleTextStyle: TextStyle(
      // //     color: AppColors.text,
      // //   ),
      // //   centerTitle: false,
      // //   color: AppColors.background,
      // // ),

      // // Define text styles for different use-cases.
      // inputDecorationTheme: InputDecorationTheme(
      //   filled: true,
      //   hintStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
      //   contentPadding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 4.w),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     // borderSide: BorderSide.none,
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     borderSide: const BorderSide(color: AppColors.darkBorder),
      //   ),
      //   errorBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: AppColors.error),
      //     borderRadius: BorderRadius.all(Radius.circular(6)),
      //   ),
      //   errorStyle: AppTextStyle.body(color: AppColors.error),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     borderSide: const BorderSide(color: AppColors.darkBorder),
      //   ),
      //   focusedErrorBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: AppColors.darkBorder),
      //     borderRadius: BorderRadius.all(Radius.circular(6)),
      //   ),
      // ),
    );
  }
}
