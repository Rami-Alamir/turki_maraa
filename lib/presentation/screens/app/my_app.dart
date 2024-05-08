import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../controllers/app_language.dart';
import '../../../controllers/app_theme.dart';
import '../../../controllers/auth.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/route_generator.dart';
import '../../../core/service/firebase_helper.dart';

//App Widget tree
class MyApp extends StatefulWidget {
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  final Locale locale;
  final String theme;
  final String token;
  MyApp(
      {super.key,
      required this.locale,
      required this.theme,
      required this.token});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AppLanguage>().appLocale = widget.locale;
    context.read<AppTheme>().setThemeData = widget.theme;
    context.read<Auth>().getUserData(context, widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Consumer2<AppLanguage, AppTheme>(
        builder: (ctx, lang, appTheme, child) {
      return MaterialApp(
        navigatorObservers: [
          FirebaseHelper.observer!,
        ],
        theme: appTheme.getThemeData,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: lang.appLocal,
        supportedLocales: const [
          Locale('ar', ''),
          Locale('en', ''),
        ],
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      );
    });
  }
}
