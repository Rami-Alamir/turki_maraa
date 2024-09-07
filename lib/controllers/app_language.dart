import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage with ChangeNotifier {
  Locale? _appLocale;
  SharedPreferences? _prefs;
  String get language =>
      (_appLocale ?? const Locale("ar")) == const Locale("ar") ? 'ar' : 'en';
  bool get isArabic => (_appLocale ?? const Locale("ar")) == const Locale("ar");

  Locale get appLocal => _appLocale ?? const Locale("ar");

  set appLocale(Locale value) {
    _appLocale = value;
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  //change app language and save in Shared Preferences
  Future<void> changeLanguage() async {
    await _initPrefs();
    if (_appLocale == const Locale("ar")) {
      _appLocale = const Locale("en");
      await _prefs?.setString('language_code', 'en');
    } else {
      _appLocale = const Locale("ar");
      await _prefs?.setString('language_code', 'ar');
    }
    notifyListeners();
  }
}
