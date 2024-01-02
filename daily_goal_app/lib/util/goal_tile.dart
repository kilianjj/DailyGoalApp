import 'package:daily_goal_app/util/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/style.dart';

/// goal repeat frequency options enum
enum RepeatFrequency { daily, weekly, monthly, yearly }

/// completion statuses
enum StreakStatus { completed, endingStreak, noStreak }

/// Goal class
/// Contains task name, streak length, last completed time, and goal frequency
class Goal {
  String task;
  int streak;
  RepeatFrequency frequency;
  DateTime lastComplete;
  StreakStatus status;

  Goal(
      {required this.task,
      required this.lastComplete,
      this.status = StreakStatus.noStreak,
      this.frequency = RepeatFrequency.daily,
      this.streak = 0});
}

/// UI goal tile element
class GoalTile extends StatelessWidget {
  /// the associate goal object
  Goal goal;

  /// index of goal tile in the list
  int checked;

  /// delete, edit, and check goal functions
  Function(BuildContext)? delete;
  Function(BuildContext)? edit;
  Function() checker;

  /// requires goal, and the field functions
  GoalTile(
      {super.key,
      required this.goal,
      required this.delete,
      required this.edit,
      required this.checked,
      required this.checker});

    String getLabel(RepeatFrequency freq){
      switch (freq) {
        case RepeatFrequency.weekly:
          return "Weekly";
        case RepeatFrequency.monthly:
          return "Monthly";
        case RepeatFrequency.yearly:
          return "Yearly";
        default:
          return "Daily";
      }
    }

  /// goal tile UI build
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
                    backgroundColor: EDIT,
                    borderRadius: BorderRadius.circular(5)),
                SlidableAction(
                    onPressed: delete,
                    icon: Icons.delete,
                    backgroundColor: DELETE,
                    borderRadius: BorderRadius.circular(5))
              ],
            ),
            child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(goal.task,
                          style: TextStyle(
                              fontSize: TEXTSIZE, color: TEXT_COLOR))),
                              Text(getLabel(goal.frequency), style: TextStyle(fontSize: TEXTSIZE, color: TEXT_COLOR)),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(goal.streak.toString(),
                      style: TextStyle(fontSize: TEXTSIZE, color: TEXT_COLOR)),
                  CompleteButton(checked: checked, updater: checker)
                ]))));
  }
}
