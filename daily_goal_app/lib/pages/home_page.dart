import 'package:daily_goal_app/util/database.dart';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/add_goal.dart';

/// textbox controller for add/edit goal dialoug box
final controller = TextEditingController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  // todo: Hive stuff

  /// update UI after goal changes
  void update() {
    setState(() {});
  }

  /// index retrieved from slideable delete button
  /// goal is removed from that indice
  /// UI is updated
  void deleteGoal(int index) {
    goals.removeAt(index);
    update();
  }

  /// index retrieved from slideable edit button
  /// set text controller to current task name
  /// open up the dialoug box
  void editGoal(int index) {
    controller.text = goals[index].task;
    deleteGoal(index);
    addGoal();
  }

  /// function for adding a new goal
  /// open dialoug box
  void addGoal() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(controller: controller, onGoalsUpdated: update);
        });
    // db.updateData();
  }

  /// UI build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("Goals"),
            backgroundColor: Colors.grey,
            elevation: 0,
            centerTitle: true),
        floatingActionButton: FloatingActionButton(
          onPressed: addGoal,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return GoalTile(
                  goal: goals[index],
                  delete: (context) => deleteGoal(index),
                  edit: (context) => editGoal(index),
                  checked: index,
                  checker: update);
            }));
  }
}