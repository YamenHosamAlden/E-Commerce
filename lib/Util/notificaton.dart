// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:kora/Core/Constants/app_colors.dart';

// class NotificatonHandler {
//   static String? fcmToken;
//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {}

//   static Future onOpendApp(BuildContext context) async {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
//   }

//   static Future inApp(BuildContext context) async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//       AndroidInitializationSettings android =
//           const AndroidInitializationSettings(
//         '@drawable/logo',
//       );
//       DarwinInitializationSettings ios = const DarwinInitializationSettings();
     
//       InitializationSettings initSettings = InitializationSettings(
//         iOS: ios,
//         android: android, /* iOS: iOS,*/
//       );
//       flutterLocalNotificationsPlugin.initialize(
//         initSettings,
//       );

//       String groupKey = 'com.example.general-notification-channel';
//       AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//               'general-notification-channel', 'general-notification-channel',
//               playSound: true,
//               color: AppColors.lightHighlightColor,
//               importance: Importance.max,
//               priority: Priority.high,
//               groupKey: groupKey,
//               icon: '@drawable/logo',
//               styleInformation: const BigTextStyleInformation('')

//               //   setAsGroupSummary: true
//               );

//       DarwinNotificationDetails iOSPlatformChannelSpecifics =
//           const DarwinNotificationDetails(
//         presentBadge: true,
//         presentSound: true,
//       );

//       NotificationDetails platformChannelSpecifics = NotificationDetails(
//           android: androidPlatformChannelSpecifics,
//           iOS: iOSPlatformChannelSpecifics);

//       flutterLocalNotificationsPlugin.show(0, message.notification!.title!,
//           message.notification!.body!, platformChannelSpecifics);
//     });
//   }
// }
