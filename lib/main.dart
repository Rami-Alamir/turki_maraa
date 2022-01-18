import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/address_provider.dart';
import 'provider/app_theme.dart';
import 'provider/home_provider.dart';
import 'provider/orders_provider.dart';
import 'screens/app/my_app.dart';
import 'package:provider/provider.dart';
import 'provider/app_language.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getAPNSToken().then((value) => print("token is $value"));
  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //get user preference
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? _language = _prefs.getString('language_code');
  String _theme = _prefs.getString('theme') ?? 'light';
  String _accessToken = _prefs.getString('accessToken') ?? '';
  Locale _locale = Locale(_language ?? 'ar');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Auth>(create: (context) => Auth()),
    ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
    ChangeNotifierProvider<AppLanguage>(create: (context) => AppLanguage()),
    ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
    ChangeNotifierProvider<AppProvider>(create: (context) => AppProvider()),
    ChangeNotifierProvider<AddressProvider>(
        create: (context) => AddressProvider()),
    ChangeNotifierProvider<CartProvider>(create: (context) => CartProvider()),
    ChangeNotifierProvider<FavouriteProvider>(
        create: (context) => FavouriteProvider()),
    ChangeNotifierProvider<OrdersProvider>(
        create: (context) => OrdersProvider()),
  ], child: MyApp(locale: _locale, theme: _theme, token: _accessToken)));
}
