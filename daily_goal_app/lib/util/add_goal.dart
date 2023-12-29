/// DialougBox for editing creating a new goal
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/dropdown.dart';
import 'package:daily_goal_app/pages/home_page.dart';
import 'package:daily_goal_app/util/goal_tile.dart';

////
/// DialogBox pop up UI element for adding a new task
///
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  // final Function(List<Goal>) onGoalsUpdated;
  final VoidCallback onGoalsUpdated;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onGoalsUpdated
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[100],
      content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
          // height: 150,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // for user input
                TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter new goal")),
                // button for confimring and adding
                Dropdown(onGoalsUpdated: onGoalsUpdated),
                // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                //   // save button
                //   Button(
                //       text: "Save",
                //       onPressed: (){}),
                //   // cancel button
                //   Button(text: "Cancel", onPressed: onCancel)
                // ])
              ])),
    );
  }
}
