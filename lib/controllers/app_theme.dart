import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme with ChangeNotifier {
  late bool isLightTheme;
  SharedPreferences? _prefs;
  final String key = "theme";
  ThemeData _theme = lightTheme;
  String _themeName = 'light';

  String get themeName => _themeName;
  ThemeData get getThemeData => _theme;

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
  void changeTheme(String theme) {
    setThemeData = theme;
    _saveToPrefs(theme);
    notifyListeners();
  }

  // save user theme to local db
  void _saveToPrefs(String theme) async {
    await _initPrefs();
    _prefs?.setString(key, theme);
  }
}

Color primaryColor = const Color.fromRGBO(118, 24, 14, 1.0);

final ThemeData classicTheme = ThemeData(
    splashColor: Colors.white,
    primaryColor: primaryColor,
    fontFamily: 'Turki',
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
      fontFamily: 'Turki',
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromRGBO(209, 178, 147, 1),
        primaryContainer: const Color.fromRGBO(217, 201, 190, 1),
        secondaryContainer: const Color.fromRGBO(150, 122, 89, 0.5)));

final ThemeData lightTheme = ThemeData(
  splashColor: Colors.white,
  primaryColor: primaryColor,
  fontFamily: 'Turki',
  canvasColor: Colors.transparent,
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
    fontFamily: 'Turki',
    color: Colors.white,
  )),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    primaryContainer: const Color.fromRGBO(240, 240, 240, 1),
    secondaryContainer: Colors.grey.withOpacity(0.5),
  ),
);

final ThemeData darkTheme = ThemeData(
    splashColor: primaryColor,
    primaryColor: primaryColor,
    fontFamily: 'Turki',
    canvasColor: Colors.transparent,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
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
      fontFamily: 'Turki',
      color: Colors.white,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromRGBO(28, 28, 28, 1),
        primaryContainer: const Color.fromRGBO(28, 28, 28, 1),
        secondaryContainer: Colors.grey.withOpacity(0.5)));

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
