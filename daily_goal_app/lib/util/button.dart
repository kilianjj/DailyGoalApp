// ignore_for_file: no_logic_in_create_state

import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/style.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/database.dart';

const int _minutesPerHour = 60;

/// check the time when a goal is marked as completed
///  based on the goals repeat frequency, see if it is valid to check off
/// if it is valid, increment the streak of that goal, mark new complete time
/// returns true if the complete was valid, false otherwise - used to change
/// button state
StreakStatus timecheck(int index, DateTime now) {
  if (DATABASE.goals[index].streak == 0) {
    return StreakStatus.noStreak;
  }
  DateTime last = DATABASE.goals[index].lastComplete;
  int difference = now.difference(last).inMinutes;
  int limit;
  switch (DATABASE.goals[index].frequency) {
    case RepeatFrequency.weekly:
      limit = _minutesPerHour * 24 * 7;
      break;
    case RepeatFrequency.monthly:
      limit = _minutesPerHour * 24 * 30;
      break;
    case RepeatFrequency.yearly:
      limit = _minutesPerHour * 24 * 365;
    default:
      limit = _minutesPerHour * 24;
  }
  if (difference <= 0) {
    return StreakStatus.completed;
  }
  if (difference >= limit) {
    DATABASE.goals[index].streak = 0;
    DATABASE.goals[index].status = StreakStatus.noStreak;
    return StreakStatus.noStreak;
  }
  return StreakStatus.endingStreak;
}

/// complete goal button and related logic
class CompleteButton extends StatefulWidget {
  /// index of button/goal in list
  final int checked;
  // UI update function
  final Function() updater;

  const CompleteButton({super.key, required this.checked, required this.updater});

  @override
  _CompleteButtonState createState() =>
      _CompleteButtonState(index: checked, updater: updater);
}

/// state of fire button
class _CompleteButtonState extends State<CompleteButton> {
  /// index of the goal/button in the list
  int index;

  /// updates UI after checking changes
  Function() updater;

  /// requires checker function, and index of the goal in the list
  _CompleteButtonState({required this.updater, required this.index});

  /// update streak
  void updateStreak(int index, DateTime time) {
    switch (DATABASE.goals[index].frequency) {
      case RepeatFrequency.weekly:
        time.add(const Duration(days: 7));
        break;
      case RepeatFrequency.monthly:
        time.add(const Duration(days: 30));
        break;
      case RepeatFrequency.yearly:
        time.add(const Duration(days: 365));
      default:
        time.add(const Duration(days: 1));
    }
    DATABASE.goals[index].lastComplete = time;
    DATABASE.goals[index].streak += 1;
    DATABASE.goals[index].status = StreakStatus.completed;
  }

  /// change the button state if applicable and call timecheck logic
  void updateUI() {
    setState(() {
      if (DATABASE.goals[index].status != StreakStatus.completed) {
        DateTime now = DateTime.now();
        if (timecheck(index, now) != StreakStatus.completed) {
          updateStreak(index, now);
          updater();
        }
        DATABASE.saveGoals();
      }
    });
  }

  /// change button appears based on the status of the goal
  Widget buildButtonChild() {
    // Customize the button's appearance based on the current streakStatus value
    // print("$status, $index"); ************ delete after testing
    switch (DATABASE.goals[index].status) {
      case StreakStatus.completed:
        return FLAME_COMPLETE;
      case StreakStatus.endingStreak:
        return FLAME_ENDING;
      case StreakStatus.noStreak:
        return FLAME_OUT;
      default:
        return FLAME_OUT;
    }
  }

  /// complete button build
  @override
  Widget build(BuildContext context) {
    return InkResponse(
        onTap: updateUI,
        child: Container(
            padding: const EdgeInsets.all(16.0), child: buildButtonChild()));
  }
}
