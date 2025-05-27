import 'package:flutter/material.dart';
import 'package:masjidku/core/constants/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'JakartaSans',
    scaffoldBackgroundColor: AppColors.white1,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.white1,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white1,
      error: AppColors.error1,
      onError: AppColors.white1,
      background: AppColors.white2,
      onBackground: AppColors.black1,
      surface: AppColors.white1,
      onSurface: AppColors.black2,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white2,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.silver2,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white1,
      foregroundColor: AppColors.black1,
      elevation: 0,
    ),
    cardColor: AppColors.white1,
    dialogBackgroundColor: AppColors.white2,
    dividerColor: AppColors.silver1,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.black1),
      bodySmall: TextStyle(color: AppColors.black2),
      titleMedium: TextStyle(
        color: AppColors.black1,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'JakartaSans',
    scaffoldBackgroundColor: AppColors.black1,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.white1,
      secondary: AppColors.secondary,
      onSecondary: AppColors.black1,
      error: AppColors.error1,
      onError: AppColors.white1,
      background: AppColors.black2,
      onBackground: AppColors.white2,
      surface: AppColors.black2,
      onSurface: AppColors.white2,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black2,
      foregroundColor: AppColors.white1,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black2,
      selectedItemColor: AppColors.tertiary,
      unselectedItemColor: AppColors.silver2,
    ),
    cardColor: AppColors.black2,
    dialogBackgroundColor: AppColors.black2,
    dividerColor: AppColors.silver4,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.white1),
      bodySmall: TextStyle(color: AppColors.white2),
      titleMedium: TextStyle(
        color: AppColors.white1,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
