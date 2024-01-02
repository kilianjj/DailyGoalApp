// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/style.dart';
import 'package:hive/hive.dart';
import 'package:daily_goal_app/util/button.dart';

// ignore: non_constant_identifier_names
var DATABASE = GoalDatabase();

class GoalDatabase {
  /// Hive box and key names
  static const String LIGHTMODEBOX = "LightModeBox";
  static const String GOALBOX = "GoalsBox";
  static const String GOALKEY = "goals";
  static const String LIGHTMODEKEY = "lightmode";

  void loadLightMode() async {
    var box = await Hive.openBox(LIGHTMODEBOX);
    LIGHTMODE_ACTIVE = box.get(LIGHTMODEKEY, defaultValue: true);
    await box.close();
  }

  void saveLightMode(bool mode) async {
    var box = await Hive.openBox(LIGHTMODEBOX);
    box.put(LIGHTMODEKEY, mode);
    if (box.get(LIGHTMODEKEY)) {
      print("light");
    } else {
      print("dark");
    }
    await box.close();
  }

  void populateInitialGoal() {
    goals = [Goal(task: "This is a goal!", lastComplete: DateTime.now())];
  }

  void saveGoals() async {
    var box = await Hive.openBox(GOALBOX);
    box.clear();
    box.addAll(goals);
    await box.close();
  }

  void loadGoals() async {
    var box = await Hive.openBox(GOALBOX);
    goals = box.values.toList() as List<Goal>;
    await box.close();
  }

  void updateStreaks() {
    for (int i = 0; i < goals.length; i++) {
      timecheck(i, DateTime.now());
    }
  }

  /// current goal list setup - will switch to hive DB soon
  List<Goal> goals = [];
  // [
  //   Goal(
  //       task: "TestGoal",
  //       frequency: RepeatFrequency.weekly,
  //       lastComplete: DateTime(2023, 12, 28, 2, 5),
  //       status: StreakStatus.endingStreak),
  //   Goal(
  //       task: "Exercise",
  //       frequency: RepeatFrequency.yearly,
  //       lastComplete: DateTime(2023, 7, 3, 0, 0),
  //       status: StreakStatus.endingStreak),
  //   Goal(
  //       task: "Exercise2",
  //       frequency: RepeatFrequency.daily,
  //       lastComplete: DateTime(2023, 12, 31, 23, 49),
  //       status: StreakStatus.endingStreak)
  // ];
}
