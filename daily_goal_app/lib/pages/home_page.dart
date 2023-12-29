import 'package:daily_goal_app/util/database.dart';
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // do Hive stuff

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("Goals"),
            backgroundColor: Colors.grey,
            elevation: 0,
            centerTitle: true),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return GoalTile(goal: goals[index]);
                }
              )
    );
  }
}
