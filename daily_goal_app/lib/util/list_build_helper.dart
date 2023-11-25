import 'package:flutter/material.dart';

ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return GoalTile(goal: goals[index]);
            }));