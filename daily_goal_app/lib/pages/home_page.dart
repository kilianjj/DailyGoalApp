import 'package:daily_goal_app/util/database.dart';
import 'dart:async';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/add_goal.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/style.dart';

/// textbox controller for add/edit goal dialoug box
final controller = TextEditingController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // scheduling UI updates every minute
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      for (int i = 0; i < DATABASE.goals.length; i++) {
        timecheck(i, DateTime.now());
      }
      update();
    });
  }

  /// update UI after goal changes
  void update() {
    DATABASE.saveGoals();
    setState(() {});
  }

  /// index retrieved from slideable delete button
  /// goal is removed from that indice
  /// UI is updated
  void deleteGoal(int index) {
    DATABASE.goals.removeAt(index);
    update();
  }

  /// index retrieved from slideable edit button
  /// set text controller to current task name
  /// open up the dialoug box
  void editGoal(int index) {
    controller.text = DATABASE.goals[index].task;
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
  }

  /// UI build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: AppBar(
          title: Text("Goals",
              style: TextStyle(color: TEXT_COLOR, fontSize: TEXTSIZE)),
          backgroundColor: BACKGROUND_COLOR,
          elevation: 0,
          centerTitle: true,
          actions: [
            // ScheduleButton(),        /// readd when revisting notifications
            IconButton(
              icon: LIGHTMODE_ACTIVE ? DARKMODE : LIGHTMODE,
              onPressed: () {
                setState(() {
                  LIGHTMODE_ACTIVE = !LIGHTMODE_ACTIVE;
                  switchColorTheme(LIGHTMODE_ACTIVE);
                });
                DATABASE.saveLightMode(LIGHTMODE_ACTIVE);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PRIMARY_COLOR,
          foregroundColor: TEXT_COLOR,
          hoverColor: EDIT,
          onPressed: addGoal,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: DATABASE.goals.length,
            itemBuilder: (context, index) {
              return GoalTile(
                  goal: DATABASE.goals[index],
                  delete: (context) => deleteGoal(index),
                  edit: (context) => editGoal(index),
                  checked: index,
                  checker: update);
            }));
  }
}
