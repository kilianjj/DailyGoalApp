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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // scheduling UI updates every minute
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      for (int i = 0; i < DATABASE.goals.length; i++) {
        timecheck(i, DateTime.now());
      }
      update();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      DATABASE.closeBoxes();
    }
  }

  /// update UI after goal changes
  void update() {
    setState(() {});
  }

  /// index retrieved from slideable delete button
  /// goal is removed from that indice
  /// UI is updated
  void deleteGoal(int index) {
    DATABASE.goals.removeAt(index);
    DATABASE.saveGoals();
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
    DATABASE.saveGoals();
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
              icon: LIGHTMODE_ACTIVE! ? DARKMODE : LIGHTMODE,
              onPressed: () {
                setState(() {
                  if (LIGHTMODE_ACTIVE!) {
                    print("light to");
                  } else {
                    print("dark to");
                  }
                  LIGHTMODE_ACTIVE = !LIGHTMODE_ACTIVE!;
                  if (LIGHTMODE_ACTIVE!) {
                    print("light");
                  } else {
                    print("dark");
                  }
                  switchColorTheme(LIGHTMODE_ACTIVE!);
                });
                DATABASE.saveLightMode(LIGHTMODE_ACTIVE!);
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
