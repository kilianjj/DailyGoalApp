import 'package:daily_goal_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/util/button.dart';
import 'package:daily_goal_app/util/database.dart';
// import hive

// make async after implementing hive???
void main() {
  dummy();
  for (int i = 0; i < goals.length; i++) {
    timecheck(i, DateTime.now());
  }
  /// ***** delete me
  runApp(const GoalApp());
}

class GoalApp extends StatelessWidget {
  const GoalApp({super.key});

  @override
  MaterialApp build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Goal App',
        home: HomePage());
  }
}
