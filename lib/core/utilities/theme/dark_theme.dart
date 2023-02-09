import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/constants.dart';

final ThemeData darkTheme = ThemeData(
    splashColor: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: Constants.fontFamily,
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(
          fontSize: 14,
          height: 2,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGray),
      displayLarge: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 20),
      displaySmall: TextStyle(
          fontSize: 20, color: AppColors.white, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(
          color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 12),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColors.darkGray,
          fontSize: 12),
      displayMedium: TextStyle(
          fontWeight: FontWeight.normal, color: AppColors.white, fontSize: 14),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        fontSize: 20,
      ),
    ),
    dialogTheme: const DialogTheme(
      contentTextStyle: TextStyle(
          color: AppColors.darkGray, fontWeight: FontWeight.w500, fontSize: 16),
    ),
    dividerTheme: const DividerThemeData(
      indent: 50,
      color: AppColors.grey,
      thickness: .35,
      endIndent: 5,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: const TextStyle(color: AppColors.white, fontSize: 20)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.white24,
      backgroundColor: AppColors.black,
      selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: Constants.fontFamily,
      color: AppColors.white,
    )),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
            secondary: AppColors.black1,
            primaryContainer: AppColors.black1,
            secondaryContainer: Colors.grey.withOpacity(0.5))
        .copyWith(background: AppColors.black));
