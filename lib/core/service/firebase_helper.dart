import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../utilities/messaging_config.dart';

class FirebaseHelper {
  static FirebaseAnalytics? analytics;
  static String? deviceToken;
  static FirebaseAnalyticsObserver? observer;
  FirebaseInAppMessaging? fiam;
  FirebaseMessaging? messaging;

  FirebaseHelper() {
    MessagingConfig.initFirebaseMessaging();
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics!);
    fiam = FirebaseInAppMessaging.instance;
    messaging = FirebaseMessaging.instance;
    // fiam!.toString();
    messaging!.getToken().then((token) {
      deviceToken = token;
      print("token is $token");
    });

    // messaging!.getAPNSToken().then((value) {
    //   // print("getAPNSToken is $value");
    // });
    messaging!.subscribeToTopic('all');
    messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void pushAnalyticsEvent(
      {required String name, String key = 'name', String? value}) {
    analytics!
        .logEvent(name: name, parameters: value == null ? null : {key: value});
  }
}
