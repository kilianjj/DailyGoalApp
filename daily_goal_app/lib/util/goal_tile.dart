// Has all goal class and UI goal tile code
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:daily_goal_app/util/button.dart';

// goal repeat frequency options
enum RepeatFrequency { daily, weekly, monthly, yearly }

/// Goal class
/// Constatins task name, time of day to check for streak, etc
class Goal {
  String task;
  int streak;
  RepeatFrequency frequency;
  TimeOfDay checkTime;
  DateTime lastComplete;

  Goal(
      {required this.task,
      required this.lastComplete,
      this.frequency = RepeatFrequency.daily,
      this.checkTime = const TimeOfDay(hour: 0, minute: 0),
      this.streak = 0});
}

// UI goal element
class GoalTile extends StatelessWidget {
  // goal attributes
  Goal goal;
  int checked;
  Function(BuildContext)? delete;
  Function(BuildContext)? edit;
  Function() checker;

  GoalTile(
      {super.key,
      required this.goal,
      required this.delete,
      required this.edit,
      required this.checked,
      required this.checker});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                    onPressed: edit,
                    icon: Icons.edit,
                    backgroundColor: Color.fromARGB(255, 206, 204, 204),
                    borderRadius: BorderRadius.circular(5)),
                SlidableAction(
                    onPressed: delete,
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(5))
              ],
            ),
            child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Color.fromARGB(115, 207, 207, 207),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(goal.task,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white))),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(goal.streak.toString(),
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  FireButton(checked: checked, checker: checker)
                ]))));
  }
}