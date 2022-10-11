import 'package:flutter/material.dart';

final ThemeData nationalDayTheme = ThemeData(
  splashColor: Colors.white,
  primaryColor: const Color.fromRGBO(35, 98, 4, 1.0),
  fontFamily: 'Turki',
  canvasColor: Colors.transparent,
  backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
        fontSize: 16,
        color: Color.fromRGBO(35, 98, 4, 1.0),
        fontWeight: FontWeight.w600),
    subtitle2: TextStyle(
        fontSize: 14,
        height: 2,
        fontWeight: FontWeight.w500,
        color: Colors.grey),
    headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        height: 1.40,
        fontSize: 20),
    headline3: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
    headline4: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
    headline5: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 1),
        fontSize: 12),
    headline2: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 0.5),
        fontSize: 14),
    headline6: TextStyle(
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
    fontFamily: 'Turki',
    color: Colors.white,
  )),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    primaryContainer: const Color.fromRGBO(240, 240, 240, 1),
    secondaryContainer: Colors.grey.withOpacity(0.5),
  ),
);
