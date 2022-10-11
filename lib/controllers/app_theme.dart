import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utilities/theme/classic_theme.dart';
import '../core/utilities/theme/dark_theme.dart';
import '../core/utilities/theme/light_theme.dart';

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
