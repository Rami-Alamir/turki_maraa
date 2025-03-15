import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingConfig {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Background message handler for Firebase Messaging
  static Future<void> messageHandler(RemoteMessage message) async {
    // Ensure the app is handling background notifications correctly
    log('Received background message: ${message.data}');

    // Check if message data is not empty
    if (message.data.isNotEmpty) {
      String? sound = message.data['sound'];
      String? title = message.data['title'];
      String? body = message.data['body'];
      String? channelId = message.data['channel_id'];

      if (title != null) {
        await flutterLocalNotificationsPlugin.show(
          0,
          title,
          body ?? '',
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelId ??
                  'high_importance_channel', // Channel ID with fallback
              'High Importance Notifications', // Channel name
              channelDescription:
                  'This channel is used for important notifications.', // Channel description
              sound: RawResourceAndroidNotificationSound(
                  sound ?? 'cowbell'), // Custom sound or fallback
              importance:
                  Importance.max, // Maximum importance for the notification
              icon: '@mipmap/ic_launcher', // Notification icon
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: sound != null ? '$sound.caf' : 'cowbell.caf',
            ),
          ),
        );
      }
      // Show notification with custom or default sound
    }
  }

  // Initialize Firebase Messaging and Local Notifications
  static Future<void> initFirebaseMessaging() async {
    await createNotificationChannel();

    // Register the background message handler
    FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);

    // Additional Firebase Messaging configuration (foreground notifications)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Received message while in foreground: ${message.data}');
      // Handle foreground message (display notifications, etc.)
      // If you want to show a local notification here, you can use flutterLocalNotificationsPlugin.show
    });
  }

  // Create the notification channel for Android
  static Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      sound: RawResourceAndroidNotificationSound('cowbell'),
      importance: Importance.max,
    );

    // Create the channel for Android devices
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
