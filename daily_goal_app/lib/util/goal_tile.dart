// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/style.dart';
import 'package:hive/hive.dart';
part 'goal_tile.g.dart';

/// goal repeat frequency options enum
@HiveType(typeId: 1)
enum RepeatFrequency {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
  @HiveField(3)
  yearly
}

/// completion status enum
@HiveType(typeId: 2)
enum StreakStatus {
  @HiveField(0)
  completed,
  @HiveField(1)
  endingStreak,
  @HiveField(2)
  noStreak
}

/// Goal class
/// Contains task name, streak length, last completed time, goal frequency,
/// and streak status
@HiveType(typeId: 0)
class Goal extends HiveObject {
  // goal name
  @HiveField(0)
  String task;
  // current streak for the goal
  @HiveField(1)
  int streak;
  // goal frequency type
  @HiveField(2)
  RepeatFrequency frequency;
  // time goal was last completed
  @HiveField(3)
  DateTime lastComplete;
  // current streak status
  @HiveField(4)
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

  /// to string for enum basically (for goal tile display)
  String getLabel(RepeatFrequency freq) {
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
                  Text(getLabel(goal.frequency),
                      style: TextStyle(fontSize: TEXTSIZE, color: TEXT_COLOR)),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(goal.streak.toString(),
                      style: TextStyle(fontSize: TEXTSIZE, color: TEXT_COLOR)),
                  CompleteButton(checked: checked, updater: checker)
                ]))));
  }
}
