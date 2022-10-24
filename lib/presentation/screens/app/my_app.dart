import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../controllers/app_language.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../controllers/app_theme.dart';
import '../../../controllers/auth.dart';
import '../../../core/utilities/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/utilities/route_generator.dart';

//App Widget tree
class MyApp extends StatefulWidget {
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  final Locale locale;
  final String theme;
  final String token;
  MyApp(
      {Key? key,
      required this.locale,
      required this.theme,
      required this.token})
      : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    final AppLanguage language =
        Provider.of<AppLanguage>(context, listen: false);
    language.appLocale = widget.locale;
    final AppTheme appTheme = Provider.of<AppTheme>(context, listen: false);
    appTheme.setThemeData = widget.theme;
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.getUserData(context, widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final appTheme = Provider.of<AppTheme>(context);
    //Consumer for change app language only
    return Consumer<AppLanguage>(builder: (ctx, lang, child) {
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
