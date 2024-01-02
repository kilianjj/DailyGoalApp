import 'package:daily_goal_app/pages/home_page.dart';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/database.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:daily_goal_app/util/goal_adapter.dart';
import 'package:hive_flutter/adapters.dart';

/// reimport when revisiting notifications
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:daily_goal_app/util/notification.dart';
// import hive

void main() async {
  /// notification stuff - leave commented out for now
  // tz.initializeTimeZones();
  // NotificationService.initNotification();
  // print(tz.local.currentTimeZone);
  // Output information about the local time zone

  /// hive stuff - load existing goals and lightmode
  ///
  await Hive.initFlutter();
  Box<Goal> goalbox = await Hive.openBox(GoalDatabase.GOALBOX);
  Box<bool> lightbox = await Hive.openBox(GoalDatabase.LIGHTMODEBOX);
  Hive.registerAdapter(GoalAdapter());
  DATABASE = GoalDatabase(goalBox: goalbox, lightBox: lightbox);
  DATABASE.loadLightMode();
  DATABASE.loadGoals();
  if (DATABASE.goals.isEmpty) {
    DATABASE.populateInitialGoal();
  }
  DATABASE.updateStreaks();

  // /// run app
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
