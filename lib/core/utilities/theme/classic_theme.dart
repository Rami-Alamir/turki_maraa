import 'package:flutter/material.dart';

import '../../constants/constants.dart';

Color primaryColor = const Color.fromRGBO(118, 24, 14, 1.0);

final ThemeData classicTheme = ThemeData(
    splashColor: Colors.white,
    primaryColor: primaryColor,
    fontFamily: KConstants.fontFamily,
    canvasColor: Colors.transparent,
    //backgroundColor: Color.fromRGBO(243, 224, 177, 1),
    backgroundColor: const Color.fromRGBO(209, 178, 147, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(209, 178, 147, 1),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontSize: 16, color: primaryColor, fontWeight: FontWeight.w600),
      subtitle2: const TextStyle(
        fontSize: 14,
        height: 2,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(150, 122, 89, 1),
      ),
      headline1: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 20),
      headline3: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
      headline4: TextStyle(
          color: primaryColor, fontWeight: FontWeight.w600, fontSize: 12),
      headline5: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(150, 122, 89, 1),
          fontSize: 12),
      headline2: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
      headline6: const TextStyle(
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
      color: Color.fromRGBO(150, 122, 89, 1),
      thickness: .35,
      endIndent: 5,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromRGBO(209, 178, 147, 1),
      selectedLabelStyle: const TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: const TextStyle(fontSize: 10, height: 2),
      selectedItemColor: primaryColor,
      unselectedItemColor: const Color.fromRGBO(150, 122, 89, 1),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: KConstants.fontFamily,
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromRGBO(209, 178, 147, 1),
        primaryContainer: const Color.fromRGBO(217, 201, 190, 1),
        secondaryContainer: const Color.fromRGBO(150, 122, 89, 0.5)));
