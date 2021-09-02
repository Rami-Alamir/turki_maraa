import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme with ChangeNotifier {
  late bool isLightTheme;
  SharedPreferences? _prefs;
  final String key = "theme";

  ThemeData get getThemeData => isLightTheme ? lightTheme : lightTheme;

  set setThemeData(bool val) {
    isLightTheme = val;
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  // change then update user theme to local db
  changeTheme() {
    isLightTheme = !isLightTheme;
    _saveToPrefs();
    notifyListeners();
  }

  // save user theme to local db
  _saveToPrefs() async {
    await _initPrefs();
    _prefs?.setBool(key, isLightTheme);
  }
}

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromRGBO(132, 15, 15, 1),
    accentColor: Color.fromRGBO(25, 25, 25, 1),
    splashColor: Color.fromRGBO(25, 25, 25, 1),
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    fontFamily: 'Tajawal',
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 28, color: Colors.white),
      subtitle2: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
      headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 24),
      headline2: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(87, 87, 87, 1),
          height: 1.40,
          fontSize: 18),
      headline3: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
      headline4: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
      headline5: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(87, 87, 87, 1),
          fontSize: 12),
      headline6: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
          color: Color.fromRGBO(87, 87, 87, 1),
          fontWeight: FontWeight.w500,
          fontSize: 16),
    ),
    dividerTheme: DividerThemeData(
      indent: 50,
      color: Colors.grey,
      thickness: .35,
      endIndent: 5,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color.fromRGBO(132, 15, 15, 1)),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: 'Tajawal',
      color: Colors.white,
    )));

final lightTheme = ThemeData(
    splashColor: Colors.white,
    primaryColor: Color.fromRGBO(129, 0, 0, 1),
    accentColor: Color.fromRGBO(212, 92, 86, 1),
    fontFamily: 'Turki',
    canvasColor: Colors.transparent,
    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
    scaffoldBackgroundColor: Color.fromRGBO(250, 250, 250, 1),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(129, 0, 0, 1),
          fontWeight: FontWeight.w600),
      subtitle2: TextStyle(fontSize: 14, color: Color.fromRGBO(87, 87, 87, 1)),
      headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 20),
      headline2: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(87, 87, 87, 1),
          height: 1.40,
          fontSize: 18),
      headline3: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
      headline4: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
      headline5: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(87, 87, 87, 1),
          fontSize: 12),
      headline6: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(87, 87, 87, 1),
        fontSize: 14,
      ),
    ),
    dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
          color: Color.fromRGBO(87, 87, 87, 1),
          fontWeight: FontWeight.w500,
          fontSize: 16),
    ),
    dividerTheme: DividerThemeData(
      indent: 50,
      color: Colors.grey,
      thickness: .35,
      endIndent: 5,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color.fromRGBO(129, 0, 0, 1)),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: 'Turki',
      color: Colors.white,
    )));
