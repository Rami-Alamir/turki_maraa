import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/constants.dart';

final ThemeData classicTheme = ThemeData(
    splashColor: AppColors.white,
    primaryColor: AppColors.primaryColor,
    fontFamily: Constants.fontFamily,
    canvasColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.cream,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: 16,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600),
      titleSmall: TextStyle(
        fontSize: 14,
        height: 2,
        fontWeight: FontWeight.w500,
        color:AppColors.brown,
      ),
      displayLarge: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 20),
      displaySmall: TextStyle(
          fontSize: 20, color: AppColors.white, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 12),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColors.brown,
          fontSize: 12),
      displayMedium: TextStyle(
          fontWeight: FontWeight.normal, color: AppColors.black, fontSize: 14),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        fontSize: 20,
      ),
    ),
    dialogTheme: const DialogTheme(
      contentTextStyle: TextStyle(
          color: AppColors.darkGray,
          fontWeight: FontWeight.w500,
          fontSize: 16),
    ),
    dividerTheme: const DividerThemeData(
      indent: 50,
      color: AppColors.brown,
      thickness: .35,
      endIndent: 5,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cream,
      selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.brown,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: const TextStyle(color: AppColors.white, fontSize: 20)),
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: Constants.fontFamily,
      color: AppColors.white,
    )),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
            secondary:  AppColors.cream,
            primaryContainer: AppColors.cream2,
            secondaryContainer: AppColors.brownWithOpacity)
        .copyWith(background:AppColors.cream,));
