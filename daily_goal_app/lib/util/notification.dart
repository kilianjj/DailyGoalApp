/// work in progress noteifications


// import 'package:daily_goal_app/util/style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:daily_goal_app/util/style.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('flutter_logo');

//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {});

//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//   }
// }

// class ScheduleButton extends StatelessWidget {
//   const ScheduleButton({super.key});

//   Future scheduleNotification(
//       {int id = 0,
//       required String title,
//       required String body,
//       required DateTime scheduleNotificationTime}) async {
//     print("Hi i ran, noti time $scheduleNotificationTime");
//     return NotificationService.notificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(scheduleNotificationTime, tz.local),
//         NotificationDetails(),
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         onPressed: () async {
//           NOTIFICATION_TIME = await showTimePicker(
//               context: context,
//               initialTime: MIDNIGHT,
//               initialEntryMode: TimePickerEntryMode.inputOnly);
//           NOTIFICATION_TIME ??= MIDNIGHT;
//           DateTime now = DateTime.now();
//           DateTime scheduled = DateTime(now.year, now.month, now.day,
//               NOTIFICATION_TIME!.hour, NOTIFICATION_TIME!.minute);
//           scheduleNotification(
//               title: "Test Notification",
//               body: "Check your goal proigress",
//               scheduleNotificationTime: scheduled);
//         },
//         icon: Icon(Icons.timer, size: 30));
//   }
// }
