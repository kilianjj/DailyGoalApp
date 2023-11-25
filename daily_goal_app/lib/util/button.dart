import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class FireButton extends StatefulWidget {
  @override
  _FireButtonState createState() => _FireButtonState();
}

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
