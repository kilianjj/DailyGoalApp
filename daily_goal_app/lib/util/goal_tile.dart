import 'package:flutter/material.dart';

class GoalTile extends StatelessWidget {
  // goal attributes
  final String name;
  int streak;
  Function(bool?)? checked;
  Function(BuildContext)? delete;

  GoalTile({
    super.key,
    required this.name,
    this.streak = 0,
    //this.checked = null;
    required this.delete
  })

  @override
  Widget build(BuildContext context){
    return const Padding(padding: EdgeInsets.all(25));
  }
}