import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static initializeLocalNotification(
      {void Function(Map<String, dynamic> data)? onNotificationPressed,
        required String icon}) async {
    // Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(icon);
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse : (payload) {
        onSelectNotification(payload: payload.payload, onData: onNotificationPressed);
      },
    );
  }

  static Future onSelectNotification({String? payload, onData}) async {
    if (payload != null) {
      print('notification payload payload $payload');
      var jsonData = jsonDecode(payload);
      onData(jsonData);
      print('jsonData $jsonData');
    }
  }

  static Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print(title);
  }

  static showNotification(
      {required RemoteNotification notification,
        Map<String, dynamic>? payload,
        String? icon}) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              icon: '@mipmap/launcher_icon',
            ),
          ),
          payload: jsonEncode(payload));
  }
}
