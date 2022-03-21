import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class FirebaseHelper {
  static FirebaseAnalytics? analytics;
  static FirebaseAnalyticsObserver? observer;
  static FirebaseInAppMessaging? fiam;
  static FirebaseDynamicLinks? dynamicLinks;

  FirebaseHelper() {
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics!);
    dynamicLinks = FirebaseDynamicLinks.instance;
    fiam = FirebaseInAppMessaging.instance;
  }
}
