import 'package:daily_goal_app/util/goal_tile.dart';

/// need to save dark/light mode too when closing app

/// current goal list setup - will switch to hive DB soon
List<Goal> goals = [
  Goal(task: "TestGoal", frequency: RepeatFrequency.daily, lastComplete:  DateTime(2023, 12, 28, 2, 5), status: StreakStatus.completed),
  Goal(task: "Exercise", frequency: RepeatFrequency.yearly, lastComplete: DateTime(2023, 3, 3, 0, 0), status: StreakStatus.endingStreak),
  Goal(task: "Exercise2", frequency: RepeatFrequency.daily, lastComplete: DateTime(2023, 12, 29, 23, 49), status: StreakStatus.endingStreak)
];