import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/constants.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  primaryColor: AppColors.primaryColor,
  fontFamily: Constants.fontFamily,
  scaffoldBackgroundColor: AppColors.white10,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  canvasColor: Colors.transparent,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 18,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: AppColors.gold,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w600,
    ),
    displayLarge: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      fontSize: 12,
    ),
    displaySmall: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    headlineMedium: TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.darkGray,
      fontSize: 12,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.gold,
      fontSize: 12,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.grey,
      fontSize: 14,
      height: 1.5,
    ),
  ),
  dialogTheme: const DialogThemeData(
    contentTextStyle: TextStyle(
      color: AppColors.darkGray1,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  ),
  dividerTheme: const DividerThemeData(
    indent: 50,
    color: AppColors.grey,
    thickness: .35,
    endIndent: 5,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white10,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.black38,
    selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
    unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
      textStyle: const TextStyle(color: AppColors.white, fontSize: 20),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(
      fontFamily: Constants.fontFamily,
      color: AppColors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primaryColor,
    tertiary: AppColors.primaryColor,
    secondary: AppColors.gold,
    surface: AppColors.white,
    shadow: AppColors.grey.withValues(alpha: 0.35),
    outline: AppColors.white20,
    primaryContainer: AppColors.white10,
    secondaryContainer: AppColors.grey.withValues(alpha: 0.5),
    tertiaryContainer: AppColors.primaryColor,
    onSecondary: AppColors.white,
    onTertiary: AppColors.purpleGray,
    onSurface: AppColors.white10,
  ),
);
