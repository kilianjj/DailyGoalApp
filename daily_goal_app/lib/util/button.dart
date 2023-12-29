// class for buttons and helper functions
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

// button for completing a goal
class FireButton extends StatefulWidget {
  @override
  _FireButtonState createState() => _FireButtonState();
}

// state of fire button
class _FireButtonState extends State<FireButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
        onTap: () {
          setState(() {
            isClicked = !isClicked; // add function to update streak
          });
        },
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: isClicked ? 
                const GradientIcon(icon: Icons.local_fire_department, 
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.pink],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                  ),
                  size: 50,
                )
                 : 
                const Icon(Icons.local_fire_department,
                size: 36.0, color: Colors.white)));
  }
}

// /// Class for Save and Cancel buttons used in add-task dialoug box
// class Button extends StatelessWidget {

//   // Button text and function called when pressed
//   final String text;
//   final VoidCallback onPressed;

//   const Button({super.key, required this.text, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(onPressed: onPressed, 
//     color: Theme.of(context).primaryColorDark,
//     child: Text(text));
//   }
// }