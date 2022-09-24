import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme with ChangeNotifier {
  late bool isLightTheme;
  SharedPreferences? _prefs;
  final String key = "theme";
  ThemeData _theme = lightTheme;
  ThemeData get getThemeData => _theme;
  String _themeName = 'light';

  String get themeName => _themeName;

  set setThemeData(String theme) {
    switch (theme) {
      case 'light':
        _theme = lightTheme;
        _themeName = 'light';
        break;
      case 'dark':
        _theme = darkTheme;
        _themeName = 'dark';

        break;
      case 'classic':
        _theme = classicTheme;
        _themeName = 'classic';
        break;
    }
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  // change then update user theme to local db
  changeTheme(String theme) {
    setThemeData = theme;
    _saveToPrefs(theme);
    notifyListeners();
  }

  // save user theme to local db
  _saveToPrefs(String theme) async {
    await _initPrefs();
    _prefs?.setString(key, theme);
  }
}

final classicTheme = ThemeData(
    splashColor: Colors.white,
    primaryColor: Color.fromRGBO(118, 24, 14, 1.0),
    fontFamily: 'Turki',
    canvasColor: Colors.transparent,
    //backgroundColor: Color.fromRGBO(243, 224, 177, 1),
    backgroundColor: Color.fromRGBO(209, 178, 147, 1),
    scaffoldBackgroundColor: Color.fromRGBO(209, 178, 147, 1),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(118, 24, 14, 1.0),
          fontWeight: FontWeight.w600),
      subtitle2: TextStyle(
        fontSize: 14,
        height: 2,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(150, 122, 89, 1),
      ),
      headline1: TextStyle(
          color: Color.fromRGBO(118, 24, 14, 1.0),
          fontWeight: FontWeight.bold,
          height: 1.40,
          fontSize: 20),
      headline3: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
      headline4: TextStyle(
          color: Color.fromRGBO(118, 24, 14, 1.0),
          fontWeight: FontWeight.w600,
          fontSize: 12),
      headline5: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(150, 122, 89, 1),
          fontSize: 12),
      headline2: TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 20,
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
      color: Color.fromRGBO(150, 122, 89, 1),
      thickness: .35,
      endIndent: 5,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(209, 178, 147, 1),
      selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
      selectedItemColor: Color.fromRGBO(118, 24, 14, 1.0),
      unselectedItemColor: Color.fromRGBO(150, 122, 89, 1),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: Color.fromRGBO(118, 24, 14, 1.0),
          textStyle: TextStyle(color: Colors.white, fontSize: 20)),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: 'Turki',
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color.fromRGBO(209, 178, 147, 1),
        primaryContainer: Color.fromRGBO(217, 201, 190, 1),
        secondaryContainer: Color.fromRGBO(150, 122, 89, 0.5)));

final lightTheme = ThemeData(
  splashColor: Colors.white,
  primaryColor: Color.fromRGBO(118, 24, 14, 1.0),
  fontFamily: 'Turki',
  canvasColor: Colors.transparent,
  backgroundColor: Color.fromRGBO(250, 250, 250, 1),
  scaffoldBackgroundColor: Color.fromRGBO(250, 250, 250, 1),
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 16,
        color: Color.fromRGBO(118, 24, 14, 1.0),
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
    selectedItemColor: Color.fromRGBO(118, 24, 14, 1.0),
    unselectedItemColor: Colors.black38,
    selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
    unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        primary: Color.fromRGBO(118, 24, 14, 1.0),
        textStyle: TextStyle(color: Colors.white, fontSize: 20)),
  ),
  snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
    fontFamily: 'Turki',
    color: Colors.white,
  )),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    primaryContainer: Color.fromRGBO(240, 240, 240, 1),
    secondaryContainer: Colors.grey.withOpacity(0.5),
  ),
);

final nDTheme = ThemeData(
  splashColor: Colors.white,
  primaryColor: const Color.fromRGBO(0, 108, 53, 1.0),
  fontFamily: 'Turki',
  canvasColor: Colors.transparent,
  backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1),
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 16,
        color: const Color.fromRGBO(0, 108, 53, 1.0),
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
    selectedItemColor: const Color.fromRGBO(0, 108, 53, 1.0),
    unselectedItemColor: Colors.black38,
    selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
    unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        primary: const Color.fromRGBO(0, 108, 53, 1.0),
        textStyle: TextStyle(color: Colors.white, fontSize: 20)),
  ),
  snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
    fontFamily: 'Turki',
    color: Colors.white,
  )),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    primaryContainer: Color.fromRGBO(240, 240, 240, 1),
    secondaryContainer: Colors.grey.withOpacity(0.5),
  ),
);

final darkTheme = ThemeData(
    splashColor: Color.fromRGBO(118, 24, 14, 1.0),
    primaryColor: Color.fromRGBO(118, 24, 14, 1.0),
    fontFamily: 'Turki',
    canvasColor: Colors.transparent,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
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
      style: TextButton.styleFrom(
          primary: Color.fromRGBO(118, 24, 14, 1.0),
          textStyle: TextStyle(color: Colors.white, fontSize: 20)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color.fromRGBO(118, 24, 14, 1.0),
      unselectedItemColor: Colors.white24,
      backgroundColor: Colors.black,
      selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
      unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: 'Turki',
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color.fromRGBO(28, 28, 28, 1),
        primaryContainer: Color.fromRGBO(28, 28, 28, 1),
        secondaryContainer: Colors.grey.withOpacity(0.5)));
