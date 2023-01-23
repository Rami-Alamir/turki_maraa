import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'core/service/firebase_helper.dart';
import 'core/service/service_locator.dart';
import 'core/utilities/providers_list.dart';
import 'presentation/screens/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  // TabbySDK().setup(
  //   withApiKey: 'sk_test_86f97925-b3e7-4d24-a4b1-9e681e59e3ad',
  //   environment: Environment.production,
  // );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // init firebase
  await Firebase.initializeApp();
  FirebaseHelper();

  //get user preference
  SharedPreferences prefs = await SharedPreferences.getInstance();
  FlutterSecureStorage localStorage = const FlutterSecureStorage();
  String accessToken = await localStorage.read(key: 'accessToken') ?? "";
  String? language = prefs.getString('language_code');
  String theme = prefs.getString('theme') ?? 'light';
  Locale locale = Locale(language ?? 'ar');

  runApp(MultiProvider(
      providers: ProvidersList.providersList(),
      child: MyApp(locale: locale, theme: theme, token: accessToken)));
}
