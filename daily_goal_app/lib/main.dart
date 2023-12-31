import 'package:daily_goal_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/database.dart';
/// reimport when revisiting notifications
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:daily_goal_app/util/notification.dart';
// import hive

// make async after implementing hive???
void main() {
  /// notification stuff - leave commented out for now
  // tz.initializeTimeZones();
  // NotificationService.initNotification();
  // print(tz.local.currentTimeZone);
  // Output information about the local time zone

  dummy(); //////////////////////// delete me ***
  for (int i = 0; i < goals.length; i++) {
    timecheck(i, DateTime.now());
  }
  runApp(const GoalApp());
}

class GoalApp extends StatelessWidget {
  const GoalApp({super.key});

  @override
  MaterialApp build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Goal App',
        home: HomePage());
  }
}
