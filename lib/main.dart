import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'core/service/firebase_helper.dart';
import 'core/utilities/providers_list.dart';
import 'presentation/screens/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TabbySDK().setup(
    withApiKey: 'sk_test_86f97925-b3e7-4d24-a4b1-9e681e59e3ad',
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
  String? language = prefs.getString('language_code');
  String theme = prefs.getString('theme') ?? 'light';
  String accessToken = prefs.getString('accessToken') ?? '';
  Locale locale = Locale(language ?? 'ar');

  runApp(MultiProvider(
      providers: ProvidersList.providersList(),
      child: MyApp(locale: locale, theme: theme, token: accessToken)));
}
