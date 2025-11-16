import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4F46E5);
  static const Color background = Color(0xFFF7F8FB);
  static const Color card = Colors.white;
  static const Color border = Color(0xFFE4E7EC);
  static const Color muted = Color(0xFFF1F2F7);
  static const Color mutedForeground = Color(0xFF858796);
  static const Color secondary = Color(0xFFEDEBFE);
  static const Color secondaryForeground = Color(0xFF4F46E5);
  static const Color accent = Color(0xFFFFE6CC);
  static const Color destructive = Color(0xFFDC2626);
  static const Color chart1 = Color(0xFFEF4444);
  static const Color chart3 = Color(0xFF10B981);
  static const Color chart4 = Color(0xFFF97316);
  static const Color chart5 = Color(0xFF6366F1);
}

ThemeData buildAppTheme() {
  final baseScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    surface: AppColors.card,
    brightness: Brightness.light,
  );

  final colorScheme = baseScheme.copyWith(
    primary: AppColors.primary,
    surface: AppColors.card,
    secondary: AppColors.secondary,
    onSecondary: AppColors.secondaryForeground,
    outline: AppColors.border,
    error: AppColors.destructive,
  );

  final textTheme = GoogleFonts.interTextTheme()
      .apply(bodyColor: Colors.black87, displayColor: Colors.black87);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.card,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: Colors.black87,
      titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
    cardTheme: CardTheme(
      color: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.muted,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.muted,
      selectedColor: AppColors.primary,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    dividerColor: AppColors.border,
  );
}
