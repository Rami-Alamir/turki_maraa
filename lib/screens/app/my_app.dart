import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/firebase_helper.dart';
import 'package:new_turki/utilities/route_generator.dart';
import '../../provider/app_theme.dart';
import '../../utilities/app_localizations.dart';
import '../../provider/app_language.dart';
import 'package:provider/provider.dart';

//App Widget tree
class MyApp extends StatefulWidget {
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  final Locale locale;
  final String theme;
  final String token;
  MyApp({required this.locale, required this.theme, required this.token});

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
    final auth = Provider.of<Auth>(context, listen: false);
    auth.getUserData(context, widget.token);

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
    final appTheme = Provider.of<AppTheme>(context);

    //Consumer for change app language only
    return Consumer<AppLanguage>(builder: (ctx, lang, child) {
      return MaterialApp(
        navigatorObservers: [
          FirebaseHelper.observer!,
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
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      );
    });
  }
}
