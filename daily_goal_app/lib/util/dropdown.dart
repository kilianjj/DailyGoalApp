import 'package:daily_goal_app/util/style.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/pages/home_page.dart';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/database.dart';

/// dropdown select class
class Dropdown extends StatefulWidget {
  final VoidCallback onGoalsUpdated;
  Dropdown({required this.onGoalsUpdated});
  @override
  _DropdownState createState() => _DropdownState();
}

/// dropdown state for adding/editing goals
class _DropdownState extends State<Dropdown> {

  /// holds the selected dropbox item
  String selectedValue = 'Daily'; 
  /// dropdown options corresponding to goal frequencies
  List<String> dropdownItems = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  /// clear the text controller and pop back the dialoug box to go to home page
  void cancel() {
    controller.clear();
    Navigator.of(context).pop(); 
  }

  /// save a new goal based on dialoug box entries
  void save(String freq) {
    setState(() {
      RepeatFrequency f = RepeatFrequency.daily;
      if (freq == "Weekly") {
        f = RepeatFrequency.weekly;
      }
      if (freq == "Monthly") {
        f = RepeatFrequency.monthly;
      }
      if (freq == "Yearly") {
        f = RepeatFrequency.yearly;
      }
      // new goal object
      Goal newGoal = Goal(
          task: controller.text, lastComplete: DateTime.now(), frequency: f);
      DATABASE.goals.add(newGoal);
      controller.clear();
      // close dialoug box
      Navigator.of(context).pop(); 
      widget.onGoalsUpdated();
    });
  }

  /// dialoug box build
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Goal Frequency:',
              style: TextStyle(fontSize: TEXTSIZE, color: TEXT_COLOR),
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              style: TextStyle(color: TEXT_COLOR),
              dropdownColor: PRIMARY_COLOR,
              focusColor: BACKGROUND_COLOR,
              iconEnabledColor: TEXT_COLOR,
              iconDisabledColor: TEXT_COLOR,
              value: selectedValue,
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(color: TEXT_COLOR)),
                );
              }).toList(),
            )
          ],
        ),
        // SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularIconButton(
                  onPressed: cancel,
                  icon: Icons.delete,
                  backgroundColor: PRIMARY_COLOR,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularIconButton(
                  onPressed: () {
                    save(selectedValue);
                  },
                  icon: Icons.check,
                  backgroundColor: PRIMARY_COLOR),
              )
          ]
        ),
      ],
    );
  }
}

/// save and cancel buttons for adding/editing goals
class CircularIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;

  const CircularIconButton({
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: TEXT_COLOR, // Icon color
        ),
      ),
    );
  }
}