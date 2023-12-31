import 'package:daily_goal_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/database.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

/// reimport when revisiting notifications
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:daily_goal_app/util/notification.dart';
// import hive

void updateStreaks() {
  for (int i = 0; i < goals.length; i++) {
    timecheck(i, DateTime.now());
  }
}

void main() async {
  /// notification stuff - leave commented out for now
  // tz.initializeTimeZones();
  // NotificationService.initNotification();
  // print(tz.local.currentTimeZone);
  // Output information about the local time zone
  WidgetsFlutterBinding.ensureInitialized();
  /////////////////// hive stuff
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // await Hive.openBox('Goals');
  // await Hive.openBox('LightMode');
  // Hive.init(appDocumentDirectory.path);
  // await Hive.openBox('myBox');
  dummy(); //////////////////////// delete me ***
  updateStreaks();
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
