import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/constants.dart';

final ThemeData classicTheme = ThemeData(
  useMaterial3: false,
  primaryColor: AppColors.authenticity,
  fontFamily: Constants.fontFamily,
  scaffoldBackgroundColor: AppColors.clarity,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  canvasColor: Colors.transparent,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 18,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: AppColors.authenticity,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: AppColors.authenticity,
      fontWeight: FontWeight.w600,
    ),
    displayLarge: TextStyle(
      color: AppColors.determination,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.determination,
      fontSize: 12,
    ),
    displaySmall: TextStyle(
      color: AppColors.determination,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    headlineMedium: TextStyle(
      color: AppColors.land,
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
      color: AppColors.authenticity,
      fontSize: 12,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.authenticity,
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
    color: AppColors.authenticity,
    thickness: .35,
    endIndent: 5,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.clarity,
    selectedItemColor: AppColors.authenticity,
    unselectedItemColor: AppColors.black38,
    selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
    unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.authenticity,
      textStyle: const TextStyle(color: AppColors.clarity, fontSize: 20),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(
      fontFamily: Constants.fontFamily,
      color: AppColors.clarity,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.authenticity,
    tertiary: AppColors.authenticity,
    secondary: AppColors.authenticity,
    surface: AppColors.clarity,
    shadow: AppColors.authenticity.withValues(alpha: 0.35),
    outline: AppColors.authenticity.withValues(alpha: 0.35),
    primaryContainer: AppColors.clarity,
    secondaryContainer: AppColors.authenticity.withValues(alpha: 0.5),
    tertiaryContainer: AppColors.authenticity,
    onSecondary: AppColors.clarity,
    onTertiary: AppColors.authenticity,
    onSurface: AppColors.clarity,
  ),
);
