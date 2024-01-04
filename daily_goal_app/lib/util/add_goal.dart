import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/style.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/dropdown.dart';

/// Dialog box pop up UI element for adding a new task
class DialogBox extends StatelessWidget {
  /// text editting controller and updateGoal function
  final TextEditingController controller;
  final VoidCallback onGoalsUpdated;
  int streak;
  StreakStatus status;
  DateTime completed;

  /// takes the controller and update function
  DialogBox(
      {super.key, required this.controller, 
      required this.onGoalsUpdated,
      required this.streak,
      required this.status,
      required this.completed
      });

  /// dialougbox build
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BACKGROUND_COLOR,
      content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
          // height: 150,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // for user input
                TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TEXT_COLOR)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TEXT_COLOR)),
                        hintStyle: TextStyle(color: TEXT_COLOR),
                        border: const OutlineInputBorder(),
                        hintText: "Enter new goal"),
                    style: TextStyle(color: TEXT_COLOR),
                    cursorColor: TEXT_COLOR),
                // button for confimring and adding
                Dropdown(onGoalsUpdated: onGoalsUpdated,
                 streak: streak, 
                 status: status, 
                 completed: completed),
              ])),
    );
  }
}
