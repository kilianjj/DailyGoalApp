// class for buttons and helper functions
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

// button for completing a goal
class FireButton extends StatefulWidget {
  Function(BuildContext)? checked;

  FireButton({super.key, required this.checked});

  @override
  _FireButtonState createState() => _FireButtonState();
}

// state of fire button
class _FireButtonState extends State<FireButton> {
  bool isClicked = false;
  int checked;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
        onTap: () {
          setState(() {
            if (isClicked == false){isClicked = !isClicked;}
          });
        },
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: isClicked
                ? const GradientIcon(
                    icon: Icons.local_fire_department,
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.pink],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                    size: 50,
                  )
                : const Icon(Icons.local_fire_department,
                    size: 36.0, color: Colors.white)));
  }
}
