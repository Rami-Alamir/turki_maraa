import 'package:flutter/material.dart';

import '../../constants/constants.dart';

final ThemeData nationalDayTheme = ThemeData(
  useMaterial3: false,
  splashColor: Colors.white,
  primaryColor: const Color.fromRGBO(35, 98, 4, 1.0),
  fontFamily: Constants.fontFamily,
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
        fontSize: 16,
        color: Color.fromRGBO(35, 98, 4, 1.0),
        fontWeight: FontWeight.w600),
    titleSmall: TextStyle(
        fontSize: 14,
        height: 2,
        fontWeight: FontWeight.w500,
        color: Colors.grey),
    displayLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        height: 1.40,
        fontSize: 20),
    displaySmall: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
    headlineMedium: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 1),
        fontSize: 12),
    displayMedium: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 0.5),
        fontSize: 14),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 20,
    ),
  ),
  dialogTheme: const DialogTheme(
    contentTextStyle: TextStyle(
        color: Color.fromRGBO(87, 87, 87, 1),
        fontWeight: FontWeight.w500,
        fontSize: 16),
  ),
  dividerTheme: const DividerThemeData(
    indent: 50,
    color: Colors.grey,
    thickness: .35,
    endIndent: 5,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
    selectedItemColor: Color.fromRGBO(35, 98, 4, 1.0),
    unselectedItemColor: Colors.black38,
    selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
    unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        foregroundColor: const Color.fromRGBO(35, 98, 4, 1.0),
        textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
  ),
  snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
    fontFamily: Constants.fontFamily,
    color: Colors.white,
  )),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: Colors.white,
        primaryContainer: const Color.fromRGBO(240, 240, 240, 1),
        secondaryContainer: Colors.grey.withOpacity(0.5),
      )
      .copyWith(surface: const Color.fromRGBO(250, 250, 250, 1)),
);
