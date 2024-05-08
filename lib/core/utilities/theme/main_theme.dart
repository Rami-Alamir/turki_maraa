import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/constants.dart';

final ThemeData mainTheme = ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.primaryColor,
    fontFamily: Constants.fontFamily,
    scaffoldBackgroundColor: AppColors.primaryColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    canvasColor: Colors.transparent,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: 18,
          height: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.gold),
      titleSmall: TextStyle(
          fontSize: 16, color: AppColors.gold, fontWeight: FontWeight.w600),
      displayLarge: TextStyle(
          color: AppColors.gold, fontSize: 14, fontWeight: FontWeight.normal),
      displayMedium: TextStyle(
          fontWeight: FontWeight.w600, color: AppColors.gold, fontSize: 12),
      displaySmall: TextStyle(
          color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 12),
      headlineMedium: TextStyle(
          color: AppColors.gold, fontWeight: FontWeight.w500, fontSize: 20),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColors.darkGold,
          fontSize: 12),
      titleLarge: TextStyle(
        fontWeight: FontWeight.normal,
        color: AppColors.gold,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColors.darkGold,
          fontSize: 14,
          height: 1.5),
    ),
    dialogTheme: const DialogTheme(
      contentTextStyle: TextStyle(
          color: AppColors.darkGray1,
          fontWeight: FontWeight.w500,
          fontSize: 16),
    ),
    dividerTheme: const DividerThemeData(
      indent: 50,
      color: AppColors.purple5,
      thickness: .35,
      endIndent: 5,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.gold100,
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
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.gold,
        tertiary: AppColors.gold,
        secondary: AppColors.gold,
        surface: AppColors.gold,
        outline: AppColors.black10,
        shadow: AppColors.black100,
        primaryContainer: AppColors.purple2,
        secondaryContainer: AppColors.purple2.withOpacity(0.5),
        tertiaryContainer: AppColors.purple,
        onBackground: AppColors.black12,
        onTertiary: AppColors.purpleGray,
        background: AppColors.primaryColor));
