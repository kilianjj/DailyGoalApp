// class for buttons and helper functions
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:daily_goal_app/util/database.dart';

// button for completing a goal
class FireButton extends StatefulWidget {
  int checked;
  Function() checker;

  FireButton({super.key, required this.checked, required this.checker});

  @override
  _FireButtonState createState() =>
      _FireButtonState(index: checked, checker: checker);
}

// state of fire button
class _FireButtonState extends State<FireButton> {
  bool isClicked = false;
  int index;
  Function() checker;

  _FireButtonState({required this.checker, required this.index});

  bool timecheck(int index) {
    DateTime now = DateTime.now();
    DateTime last = goals[index].lastComplete;
    int difference = now.difference(last).inHours;
    // print("$difference, $goals[index].frequency");
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

  void updateUI() {
    if (timecheck(index)) {
      setState(() {
        if (isClicked == false) {
          timecheck(index);
          isClicked = !isClicked;
          checker;  // or checker()
        }
      });
    }
  }

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
