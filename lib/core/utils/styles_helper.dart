import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coubot/core/extensions/num_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTheme class
abstract class AppTextStyle {
  /// displaySmall figma properties
  /// fontFamily: Montserrat
  /// fontSize: 33px
  /// height: 150%
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle displaySmall({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 33.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w600,
      );

  /// try figma properties
  /// fontFamily: Montserrat
  /// fontSize: 23px
  /// height: 150%
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle tryS({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 23.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w600,
      );

  /// titleMedium figma properties
  /// fontFamily: Montserrat
  /// fontSize: 18px
  /// height: 28px
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle titleMedium({required Color color}) =>
      GoogleFonts.montserrat(
        fontSize: 18.getResponsiveFontSize,
        height: 1.56,
        color: color,
        fontWeight: FontWeight.w700,
      );

  /// bigBody figma properties
  /// fontFamily: Montserrat
  /// fontSize: 14px
  /// height: 24px
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle bigBody({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 14.getResponsiveFontSize,
        height: 1.71,
        color: color,
        fontWeight: FontWeight.w600,
      );

  /// buttonsContent figma properties
  /// fontFamily: Montserrat
  /// fontSize: 16px
  /// height: 150%
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle buttonsContent({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 16.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w600,
      );

  /// mediumBody figma properties
  /// fontFamily: Montserrat
  /// fontSize: 13px
  /// height: 150%
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle largeBody({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 13.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w600,
      );

  /// body figma properties
  /// fontFamily: Montserrat
  /// fontSize: 12px
  /// height: 167.4%
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle body({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 12.getResponsiveFontSize,
        height: 1.67,
        color: color,
        fontWeight: FontWeight.w500,
      );

  /// smallBody figma properties
  /// fontFamily: Montserrat
  /// fontSize: 11px
  /// height: 167.4%
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle mediumBody({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 11.getResponsiveFontSize,
        height: 1.67,
        color: color,
        fontWeight: FontWeight.w500,
      );

  /// verySmallBody figma properties
  /// fontFamily: Montserrat
  /// fontSize: 10px
  /// height: 150%
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle smallBody({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 10.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w500,
      );

  /// labelSmall figma properties
  /// fontFamily: Montserrat
  /// fontSize: 11px
  /// height: 150%
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle labelSmall({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 11.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w700,
      );

  /// displayLarge figma properties
  /// fontFamily: Montserrat
  /// fontSize: 50px
  /// height: 150%
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static TextStyle displayLarge({
    required Color color,
  }) =>
      GoogleFonts.montserrat(
        fontSize: 50.getResponsiveFontSize,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.w700,
      );
}
