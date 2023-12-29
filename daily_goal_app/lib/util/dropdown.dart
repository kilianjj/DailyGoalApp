import 'package:flutter/material.dart';
import 'package:daily_goal_app/pages/home_page.dart';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:daily_goal_app/util/database.dart';

class Dropdown extends StatefulWidget {
  // final Function(List<Goal>) onGoalsUpdated;
  final VoidCallback onGoalsUpdated;
  Dropdown({required this.onGoalsUpdated});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String selectedValue = 'Daily'; // Holds the selected value

  List<String> dropdownItems = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  void cancel() {
    CONTROLLER.clear();
    Navigator.of(context).pop(); // close dialoug box
  }

  // save a goal
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
      Goal newGoal = Goal(
          task: CONTROLLER.text, lastComplete: DateTime.now(), frequency: f);
      goals.add(newGoal);
      CONTROLLER.clear();
      Navigator.of(context).pop(); // close dialoug box
      print(goals);
      widget.onGoalsUpdated();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              'Goal Frequency:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedValue,
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            )
          ],
        ),
        // SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                save(selectedValue);
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: cancel,
              child: Text('Cancel'),
            )
          ],
        ),
      ],
    );
  }

  void myOnPressedFunction(String selectedValue) {
    // Your logic using the selected value
    print('Button pressed with selected value: $selectedValue');
  }
}
