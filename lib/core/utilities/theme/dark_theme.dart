import 'package:flutter/material.dart';
import '../../constants/constants.dart';

Color primaryColor = const Color.fromRGBO(118, 24, 14, 1.0);

final ThemeData darkTheme = ThemeData(
    splashColor: primaryColor,
    primaryColor: primaryColor,
    fontFamily: Constants.fontFamily,
    canvasColor: Colors.transparent,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
      subtitle1: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      subtitle2: TextStyle(
          fontSize: 14,
          height: 2,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(87, 87, 87, 1)),
      headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 20),
      headline3: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
      headline4: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
      headline5: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(87, 87, 87, 1),
          fontSize: 12),
      headline2: TextStyle(
          fontWeight: FontWeight.normal, color: Colors.white, fontSize: 14),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white24,
      backgroundColor: Colors.black,
      selectedLabelStyle: const TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: const TextStyle(fontSize: 10, height: 2),
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: Constants.fontFamily,
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromRGBO(28, 28, 28, 1),
        primaryContainer: const Color.fromRGBO(28, 28, 28, 1),
        secondaryContainer: Colors.grey.withOpacity(0.5)));
