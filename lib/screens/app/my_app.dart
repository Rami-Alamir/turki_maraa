import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_turki/screens/intro/intro2.dart';
import '../../provider/app_theme.dart';
import '../../utilities/app_localizations.dart';
import '../../provider/app_language.dart';
import 'package:provider/provider.dart';

//App Widget tree
class MyApp extends StatefulWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  final Locale locale;
  final String theme;

  MyApp({required this.locale, required this.theme});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final language = Provider.of<AppLanguage>(context, listen: false);
    language.appLocale = widget.locale;
    final appTheme = Provider.of<AppTheme>(context, listen: false);
    appTheme.setThemeData = widget.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    // make app portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    FirebaseAnalytics analytics = FirebaseAnalytics();
    final appTheme = Provider.of<AppTheme>(context);

    //Consumer for change app language only
    return Consumer<AppLanguage>(builder: (ctx, lang, child) {
      return MaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          theme: appTheme.getThemeData,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: lang.appLocal,
          supportedLocales: [
            Locale('ar', ''),
            Locale('en', ''),
          ],
          home: LayoutBuilder(builder: (ctx, constraints) {
            return Intro2();
          }));
    });
  }
}
