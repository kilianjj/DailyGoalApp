import 'package:daily_goal_app/util/goal_tile.dart';

/// current goal list setup - will switch to hive DB soon
List<Goal> goals = [
  Goal(task: "TestGoal", frequency: RepeatFrequency.daily, lastComplete:  DateTime(2023, 12, 30, 20, 5)),
  Goal(task: "Exercise", frequency: RepeatFrequency.yearly, lastComplete: DateTime(2023, 3, 3, 0, 0)),
  Goal(task: "Exercise2", frequency: RepeatFrequency.daily, lastComplete: DateTime(2023, 12, 29, 23, 12))
];