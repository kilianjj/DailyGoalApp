import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:daily_goal_app/util/button.dart';

enum RepeatDuration { daily, weekly, monthly, yearly }

class Goal {
  String name;
  int streak;
  RepeatDuration duration;

  Goal({required this.name, required this.streak, required this.duration});
}

class GoalTile extends StatelessWidget {
  // goal attributes
  Goal goal;
  //Function(bool?)? checked;
  //Function(BuildContext)? delete;

  GoalTile({super.key, required this.goal
      //this.checked = null;
      //required this.delete
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                    onPressed: null,
                    icon: Icons.edit,
                    backgroundColor: Color.fromARGB(255, 206, 204, 204),
                    borderRadius: BorderRadius.circular(5)),
                SlidableAction(
                    onPressed: null,
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(5))
              ],
            ),
            child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Color.fromARGB(115, 207, 207, 207),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: 
                            Text(goal.name,
                              style: const TextStyle(
                              fontSize: 20, color: Colors.white))),
                            const Padding(padding: EdgeInsets.all(5)),
                            Text(goal.streak.toString(), 
                               style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                            FireButton()
                ]))));
  }
}
