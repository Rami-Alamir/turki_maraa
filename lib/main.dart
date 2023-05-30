import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'core/constants/constants.dart';
import 'core/service/firebase_helper.dart';
import 'core/service/service_locator.dart';
import 'core/utilities/providers_list.dart';
import 'presentation/screens/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator().init();
  TabbySDK().setup(
    withApiKey: Constants.tabbyApiKey,
    environment: Environment.production,
  );
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
  String theme = prefs.getString('app_theme') ?? 'main';
  Locale locale = Locale(language ?? 'ar');

  runApp(MultiProvider(
      providers: ProvidersList.providersList(),
      child: MyApp(locale: locale, theme: theme, token: accessToken)));
}
