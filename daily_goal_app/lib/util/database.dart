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
  static const String LIGHTMODEBOX = "LIGHT";
  static const String GOALBOX = "GOALS";
  static const String GOALKEY = "goalkey";
  static const String LIGHTMODEKEY = "lightkey";
  static late Box<Goal> GBOX;
  static late Box<bool> LBOX;

  void closeBoxes() {
    GBOX.close();
    LBOX.close();
  }

  Future<bool> loadLightMode() async {
    return LBOX.get(LIGHTMODEKEY, defaultValue: true)!;
  }

  void saveLightMode(bool mode) async {
    LBOX.put(LIGHTMODEKEY, mode);
  }

  void populateInitialGoal() {
    goals = [Goal(task: "This is a goal!", lastComplete: DateTime.now())];
  }

  void saveGoals() async {
    GBOX.clear();
    GBOX.addAll(goals);
  }

  void loadGoals() async {
    goals = GBOX.values.toList();
  }

  void updateStreaks() {
    for (int i = 0; i < goals.length; i++) {
      timecheck(i, DateTime.now());
    }
  }

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
