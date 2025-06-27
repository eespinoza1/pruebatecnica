// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color turquoise     = Color.fromRGBO(39, 185, 222, 1);
  static const Color turquoiseDark = Color.fromARGB(255, 23, 171, 212);
}

class AppTheme {
  /// Tema claro (ya lo tenías)
  static ThemeData light = ThemeData(
    primaryColor: AppColors.turquoise,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.turquoise,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.turquoise,
    ),
  );

  /// Tema oscuro
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.turquoiseDark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.turquoiseDark,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.turquoiseDark,
    ),
  );
}
