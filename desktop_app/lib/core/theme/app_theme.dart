import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6366F1); // Indigo
  static const Color primaryVariant = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF10B981); // Emerald
  static const Color backgroundColor = Color(0xFF0F172A); // Slate 900
  static const Color surfaceColor = Color(0xFF1E293B); // Slate 800
  static const Color errorColor = Color(0xFFEF4444); // Red 500
  static const Color onPrimary = Colors.white;
  static const Color onBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color onSurface = Color(0xFFF1F5F9); // Slate 100
  static const Color onSurfaceVariant = Color(0xFF94A3B8); // Slate 400

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: onPrimary,
        onSecondary: Colors.white,
        onSurface: onSurface,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: onSurface),
        titleTextStyle: TextStyle(
          color: onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // cardTheme removed to avoid version conflicts
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceColor,
        selectedIconTheme: const IconThemeData(color: primaryColor),
        unselectedIconTheme: const IconThemeData(color: onSurfaceVariant),
        selectedLabelTextStyle: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        unselectedLabelTextStyle: const TextStyle(color: onSurfaceVariant),
        indicatorColor: primaryColor.withAlpha(25),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: onBackground, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: onBackground, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: onBackground, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: onSurface),
        bodyMedium: TextStyle(color: onSurfaceVariant),
      ),
    );
  }
}
