import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:daily_goal_app/util/database.dart';

/// complete goal button and related logic
class CompleteButton extends StatefulWidget {
  final int checked;
  final Function() checker;

  CompleteButton({super.key, required this.checked, required this.checker});

  @override
  _CompleteButtonState createState() =>
      _CompleteButtonState(index: checked, checker: checker);
}

/// state of fire button
class _CompleteButtonState extends State<CompleteButton> {
  // set default is clicked to false
  bool isClicked = false;
  int index;
  Function() checker;

  /// requires checker function, and index of the goal in the list
  _CompleteButtonState({required this.checker, required this.index});

  /// check the time when a goal is marked as completed
  ///  based on the goals repeat frequency, see if it is valid to check off
  /// if it is valid, increment the streak of that goal, mark new complete time
  /// returns true if the complete was valid, false otherwise - used to change
  /// button state
  bool timecheck(int index) {
    DateTime now = DateTime.now();
    DateTime last = goals[index].lastComplete;
    int difference = now.difference(last).inHours;
    int max;
    int min;
    switch (goals[index].frequency) {
      case RepeatFrequency.weekly:
        max = 168;
        min = 84;
        break;
      case RepeatFrequency.monthly:
        max = 720;
        min = 360;
        break;
      case RepeatFrequency.yearly:
        max = 8760;
        min = 4380;
      default:
        max = 24;
        min = 12;
    }
    if (difference < max && difference > min) {
      goals[index].lastComplete = now;
      goals[index].streak += 1;
      return true;
    } else {
      return false;
    }
  }

  /// change the button state if applicable and call timecheck logic
  void updateUI() {
    setState(() {
      if (!isClicked) {
        if (timecheck(index)){
          isClicked = !isClicked;
        checker();
        }
      }
    });
  }

  /// complete button build
  @override
  Widget build(BuildContext context) {
    return InkResponse(
        onTap: updateUI,
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: isClicked
                ? const GradientIcon(
                    icon: Icons.local_fire_department,
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.pink],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                    size: 50,
                  )
                : const Icon(Icons.local_fire_department,
                    size: 36.0, color: Colors.white)));
  }
}