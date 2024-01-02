// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/style.dart';
import 'package:hive/hive.dart';
import 'package:daily_goal_app/util/button.dart';

// ignore: non_constant_identifier_names
var DATABASE;

class GoalDatabase {
  /// Hive box and key names
  static const String LIGHTMODEBOX = "LIGHT";
  static const String GOALBOX = "GOALS";
  static const String GOALKEY = "goalkey";
  static const String LIGHTMODEKEY = "lightkey";

  Box<Goal> goalBox;
  Box<bool> lightBox;

  GoalDatabase({required this.goalBox, required this.lightBox});

  void closeBoxes() {
    goalBox.close();
    lightBox.close();
  }

  void loadLightMode() async {
    LIGHTMODE_ACTIVE = lightBox.get(LIGHTMODEKEY, defaultValue: true);
  }

  void saveLightMode(bool mode) async {
    lightBox.put(LIGHTMODEKEY, mode);
  }

  void populateInitialGoal() {
    goals = [Goal(task: "This is a goal!", lastComplete: DateTime.now())];
  }

  void saveGoals() async {
    goalBox.clear();
    goalBox.addAll(goals);
  }

  void loadGoals() async {
    goals = goalBox.values.toList();
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
