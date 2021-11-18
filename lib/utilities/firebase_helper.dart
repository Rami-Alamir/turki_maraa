import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class FirebaseHelper {
  static FirebaseAnalytics? analytics;
  static FirebaseAnalyticsObserver? observer;
  static FirebaseInAppMessaging? fiam;

  FirebaseHelper() {
    analytics = FirebaseAnalytics();
    observer = FirebaseAnalyticsObserver(analytics: analytics!);
    fiam = FirebaseInAppMessaging();
  }
}
