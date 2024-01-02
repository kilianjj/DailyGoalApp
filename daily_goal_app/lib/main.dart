import 'package:daily_goal_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/database.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/goal_adapter.dart';
import 'package:daily_goal_app/util/style.dart';
/// reimport when revisiting notifications
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:daily_goal_app/util/notification.dart';
// import hive

void initHiveBoxes() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox<Goal>('GoalsBox');
  await Hive.openBox<bool>('LightModeBox');
  Hive.registerAdapter(GoalAdapter());
}

void main() async {
  /// notification stuff - leave commented out for now
  // tz.initializeTimeZones();
  // NotificationService.initNotification();
  // print(tz.local.currentTimeZone);
  // Output information about the local time zone
  WidgetsFlutterBinding.ensureInitialized();
  /// hive stuff - load existing goals and lightmode
  initHiveBoxes();
  LIGHTMODE_ACTIVE = DATABASE.loadLightMode();
  DATABASE.goals = DATABASE.loadGoals();
  if (DATABASE.goals.isEmpty) {
    DATABASE.populateInitialGoal();
  }
  dummy(); //////////////////////// delete me ***
  /// update streak status based on current time
  DATABASE.updateStreaks();
  /// run app
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
