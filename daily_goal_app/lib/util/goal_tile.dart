import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(5)
            ),
            SlidableAction(
                onPressed: null,
                icon: Icons.edit,
                backgroundColor: Colors.grey,
                borderRadius: BorderRadius.circular(5)
              )
          ],
        ),
        child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, 
                borderRadius: BorderRadius.circular(5)
                ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(goal.name, style: const TextStyle(
                    fontSize: 20
                  ))
                  )
                ])
            )
        )
      );
  }
}
