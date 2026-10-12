import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized Inter typography helpers matching the app design system.
abstract final class GlobalTextStyles {
  /// Forces offline-safe font resolution. Matching Inter assets are bundled in
  /// `assets/fonts`, so the package must never fetch fonts at runtime.
  static void init() {
    GoogleFonts.config.allowRuntimeFetching = false;
  }

  /// Applies Inter to a complete Material text theme while preserving each
  /// role's size, weight, height, and letter spacing.
  static TextTheme interTextTheme(TextTheme textTheme) {
    init();
    return GoogleFonts.interTextTheme(textTheme);
  }

  /// Creates an Inter text style for exceptional component-specific typography.
  /// Prefer `context.textTheme` for standard Material roles.
  static TextStyle interTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    init();
    final safeWeight = (fontWeight == FontWeight.w600 ||
            fontWeight == FontWeight.w700 ||
            fontWeight == FontWeight.bold ||
            fontWeight == FontWeight.w800 ||
            fontWeight == FontWeight.w900)
        ? FontWeight.w500
        : fontWeight;
    return GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontWeight: safeWeight,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// Standard 14 px body style from the UX typography specification.
  static TextStyle interBodyTextStyle({
    double fontSize = 14,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    double height = 20 / 14,
    double letterSpacing = 0.224,
  }) {
    init();
    final safeWeight = (fontWeight == FontWeight.w600 ||
            fontWeight == FontWeight.w700 ||
            fontWeight == FontWeight.bold ||
            fontWeight == FontWeight.w800 ||
            fontWeight == FontWeight.w900)
        ? FontWeight.w500
        : fontWeight;
    return GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontWeight: safeWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
