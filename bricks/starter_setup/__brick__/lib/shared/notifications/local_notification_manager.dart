import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'model/notification_message.dart';

class LocalNotificationManager {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  // static const iOSNotificationChannel

  static const _initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  static const _initializationSettingsIOs = DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void showNotification(NotificationMessage message) {
    _flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
        android: _initializationSettingsAndroid,
        iOS: _initializationSettingsIOs));

    _flutterLocalNotificationsPlugin.show(
      0,
      message.title,
      message.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          // _androidChannel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert:
              true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
          presentBadge:
              true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
          presentSound:
              true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
          // sound: true,  // Specifics the file path to play (only from iOS 10 onwards)
          badgeNumber: 1, // The application's icon badge number
          attachments: null,
          // subtitle: String?, //Secondary description  (only from iOS 10 onwards)
          // threadIdentifier: String? (only from iOS 10 onwards)
        ),
      ),
    );
  }
}
