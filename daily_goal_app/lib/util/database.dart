import 'package:daily_goal_app/util/goal_tile.dart';

/// need to save dark/light mode too when closing app and noti time

/// current goal list setup - will switch to hive DB soon
List<Goal> goals = [
  Goal(task: "TestGoal", frequency: RepeatFrequency.weekly, lastComplete:  DateTime(2023, 12, 28, 2, 5), status: StreakStatus.endingStreak),
  Goal(task: "Exercise", frequency: RepeatFrequency.yearly, lastComplete: DateTime(2023, 7, 3, 0, 0), status: StreakStatus.endingStreak),
  Goal(task: "Exercise2", frequency: RepeatFrequency.daily, lastComplete: DateTime(2023, 12, 31, 23, 49), status: StreakStatus.endingStreak)
];