import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/app_theme.dart';
import 'screens/app/my_app.dart';
import 'package:provider/provider.dart';
import 'provider/app_language.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //get last app localization
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? _language = _prefs.getString('language_code');
  bool _theme = _prefs.getBool('theme') ?? true;

  Locale _locale = Locale(_language ?? 'ar');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppLanguage>(create: (context) => AppLanguage()),
    ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
    ChangeNotifierProvider<AppProvider>(create: (context) => AppProvider()),
  ], child: MyApp(locale: _locale, theme: _theme)));
}

//fcm route action

// @override
// void initState() {
//   super.initState();
//   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//     onMessageOpenedApp = "p :${event.data.toString()}";
//     setState(() {});
//     print("e :${event.data.toString()}");
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ItemDetails()),
//     );
//   });
//
//     FirebaseMessaging.onMessage.listen((event) {
//       onMessage = event.data['route'].toString();
//       setState(() {});
//       print(event.data['route'].toString());
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ItemDetails()),
//       );
//     });
//     Future<void> _firebaseMessagingBackgroundHandler(
//         RemoteMessage message) async {
//       onBackgroundMessage = "m: ${message.data.toString()}";
//       setState(() {});
//       print("m: ${message.data.toString()}");
//       print(message.data['route'].toString());
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ItemDetails()),
//       );
//     }
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
