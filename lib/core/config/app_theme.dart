import 'package:flutter/material.dart';

// --- Colors ---
class AppColors {
  // Primary Brand Colors (Dark Blue / Indigo)
  static const Color primary = Color(0xFF1A237E); // Deep Indigo
  static const Color primaryDark = Color(0xFF0D174E);

  // Accent / Action Colors (Sharp Teal/Green)
  static const Color accent = Color(0xFF00BCD4);
  static const Color accentDark = Color(0xFF0097A7);

  // Backgrounds
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Color(
    0xFF121212,
  ); // Standard dark mode background
}

// --- Light Theme ---
ThemeData lightTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      background: AppColors.backgroundLight,
      onBackground: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // ... define other light theme elements (text, buttons)
  );
}

// --- Dark Theme ---
ThemeData darkTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryDark,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.accentDark,
      background: AppColors.backgroundDark,
      onBackground: Colors.white70,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // ... define other dark theme elements
  );
}
