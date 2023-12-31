import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:daily_goal_app/util/database.dart';

/// completion statuses
enum StreakStatus { completed, endingStreak, noStreak }

int _minutesPerHour = 60;

/// check the time when a goal is marked as completed
///  based on the goals repeat frequency, see if it is valid to check off
/// if it is valid, increment the streak of that goal, mark new complete time
/// returns true if the complete was valid, false otherwise - used to change
/// button state
StreakStatus timecheck(int index, DateTime now) {
  if (goals[index].streak == 0) {
    return StreakStatus.noStreak;
  }
  DateTime last = goals[index].lastComplete;
  int difference = now.difference(last).inMinutes;
  int max;
  int min;
  switch (goals[index].frequency) {
    case RepeatFrequency.weekly:
      max = _minutesPerHour * 24 * 7;
      min = _minutesPerHour * 24 * 7 ~/ 2;
      break;
    case RepeatFrequency.monthly:
      max = _minutesPerHour * 24 * 30;
      min = _minutesPerHour * 24 * 30 ~/ 2;
      break;
    case RepeatFrequency.yearly:
      max = _minutesPerHour * 24 * 365;
      min = _minutesPerHour * 24 * 365 ~/ 2;
    default:
      max = _minutesPerHour * 24;
      min = _minutesPerHour * 24 ~/ 2;
  }
  if (difference > max) {
    goals[index].streak = 0;
    return StreakStatus.noStreak;
  }
  if (difference > min) {
    return StreakStatus.endingStreak;
  }
  return StreakStatus.completed;
}

/// complete goal button and related logic
class CompleteButton extends StatefulWidget {
  final int checked;
  final Function() updater;

  CompleteButton({super.key, required this.checked, required this.updater});

  @override
  _CompleteButtonState createState() =>
      _CompleteButtonState(index: checked, updater: updater);
}

/// state of fire button
class _CompleteButtonState extends State<CompleteButton> {
  /// status of button will be determined upon time and last complete of goal
  /// in the constructor
  late StreakStatus status;

  /// index of the goal/button in the list
  int index;

  /// updates UI after checking changes
  Function() updater;

  /// requires checker function, and index of the goal in the list
  _CompleteButtonState({required this.updater, required this.index}) {
    status = timecheck(index, DateTime.now());
  }

  /// update streak
  void updateStreak(int index, DateTime time) {
    goals[index].lastComplete = time;
    goals[index].streak += 1;
  }

  /// change the button state if applicable and call timecheck logic
  void updateUI() {
    setState(() {
      if (status != StreakStatus.completed) {
        DateTime now = DateTime.now();
        if (timecheck(index, now) != StreakStatus.completed) {
          updateStreak(index, now);
          status = StreakStatus.completed;
          updater();
        }
      }
    });
  }

  Widget buildButtonChild() {
    // Customize the button's appearance based on the current streakStatus value
    // print("$status, $index"); ************ delete after testing
    switch (status) {
      case StreakStatus.completed:
        return const GradientIcon(
            icon: Icons.local_fire_department,
            gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.pink],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            size: 50);
      case StreakStatus.endingStreak:
        return const Icon(Icons.local_fire_department,
            size: 36.0, color: Colors.yellow);
      case StreakStatus.noStreak:
        return const Icon(Icons.local_fire_department,
            size: 36.0, color: Colors.white);
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
