import 'package:flutter/material.dart';
import '../../constants/constants.dart';

Color primaryColor = const Color.fromRGBO(118, 24, 14, 1.0);

final ThemeData lightTheme = ThemeData(
  splashColor: Colors.white,
  primaryColor: primaryColor,
  fontFamily: Constants.fontFamily,
  canvasColor: Colors.transparent,
  highlightColor: Colors.transparent,
  backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 16, color: primaryColor, fontWeight: FontWeight.w600),
    subtitle2: const TextStyle(
        fontSize: 14,
        height: 2,
        fontWeight: FontWeight.w500,
        color: Colors.grey),
    headline1: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        height: 1.40,
        fontSize: 20),
    headline3: const TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
    headline4: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
    headline5: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 1),
        fontSize: 12),
    headline2: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 0.5),
        fontSize: 14),
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
    color: Colors.grey,
    thickness: .35,
    endIndent: 5,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.black38,
    selectedLabelStyle: const TextStyle(fontSize: 12, height: 2),
    unselectedLabelStyle: const TextStyle(fontSize: 10, height: 2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
  ),
  snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
    fontFamily: Constants.fontFamily,
    color: Colors.white,
  )),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    primaryContainer: const Color.fromRGBO(240, 240, 240, 1),
    secondaryContainer: Colors.grey.withOpacity(0.5),
  ),
);
