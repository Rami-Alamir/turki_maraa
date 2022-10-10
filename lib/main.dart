import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'core/service/firebase_helper.dart';
import 'core/utilities/providers_list.dart';
import 'presentation/screens/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // init firebase
  await Firebase.initializeApp();
  FirebaseHelper();

  //get user preference
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? language = prefs.getString('language_code');
  String theme = prefs.getString('theme') ?? 'light';
  String accessToken = prefs.getString('accessToken') ?? '';
  Locale locale = Locale(language ?? 'ar');

  runApp(MultiProvider(
      providers: ProvidersList.providersList(),
      child: MyApp(locale: locale, theme: theme, token: accessToken)));
}
