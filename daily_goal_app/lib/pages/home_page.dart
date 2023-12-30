// page showing goals
import 'package:daily_goal_app/util/database.dart';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/add_goal.dart';

final CONTROLLER = TextEditingController();

// homepage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// homepage state
class _HomePageState extends State<HomePage> {
  // do Hive stuff

  void update() {
    setState(() {});
  }

  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
    update();
  }

  void editGoal(int index) {
    CONTROLLER.text = goals[index].task;
    deleteGoal(index);
    addGoal();
  }

  void checkGoal(int index) {
    print(index);
    goals[index].streak += 1;
    update();
  }

  // function for adding a new goal
  void addGoal() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(controller: CONTROLLER, onGoalsUpdated: update);
        });
    // db.updateData();
  }

  // page UI build
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
                  checked: index);
            }));
  }
}
