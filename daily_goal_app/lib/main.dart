import 'package:daily_goal_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_goal_app/pages/home_page.dart';
// import hive
// import pages

// make async
void main() {
  dummy();
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
