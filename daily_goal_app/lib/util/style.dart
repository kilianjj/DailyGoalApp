// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

/// todo: put global style stuff in here
/// 
/// other icons to consider: trip origin, check circle, task alt, etc
/// 
/// 

////////// revisit when doing notis
// TimeOfDay? NOTIFICATION_TIME = MIDNIGHT;
// const TimeOfDay MIDNIGHT = TimeOfDay(hour: 0, minute: 0);

const Icon FLAME_OUT =
    Icon(Icons.local_fire_department_outlined, size: ICON_SIZE, color: WHITE);
const Icon FLAME_ENDING =
    Icon(Icons.local_fire_department_outlined, size: ICON_SIZE, color: FLAME3);
const GradientIcon FLAME_COMPLETE =
    GradientIcon(icon: Icons.local_fire_department_outlined,
                  gradient: LinearGradient(colors: [FLAME1, FLAME2],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
                  size: ICON_SIZE);    
const Icon DARKMODE = Icon(Icons.bedtime, size: 30, color: WHITE);
const Icon LIGHTMODE = Icon(Icons.light_mode, size:30, color: WHITE);

const Color LIGHT_PRIMARY = Color.fromARGB(255, 176, 205, 228);
const Color DARK_PRIMARY = Color.fromARGB(255, 9, 38, 61);
const Color LIGHT_SECONDARY = Color.fromARGB(255, 211, 232, 250);
const Color DARK_SECONDARY = Color.fromARGB(255, 3, 55, 97);
const Color BLACK = Colors.black;
const Color WHITE = Colors.white;
const Color DELETE = Colors.red;
const Color EDIT = Color.fromARGB(255, 206, 204, 204);
const Color FLAME1 = Colors.deepOrange;
const Color FLAME2 = Colors.pink;
const Color FLAME3 = Colors.yellow;

const double TEXTSIZE = 24;
const double ICON_SIZE = 50;

bool LIGHTMODE_ACTIVE = true;
Color BACKGROUND_COLOR = LIGHT_PRIMARY;
Color PRIMARY_COLOR = LIGHT_SECONDARY;
Color TEXT_COLOR = BLACK;

void switchColorTheme(bool lightMode) {
  if (lightMode) {
    BACKGROUND_COLOR = LIGHT_PRIMARY;
    PRIMARY_COLOR = LIGHT_SECONDARY;
    TEXT_COLOR = BLACK;
  } else {
    BACKGROUND_COLOR = DARK_PRIMARY;
    PRIMARY_COLOR = DARK_SECONDARY;
    TEXT_COLOR = WHITE;
  }
}
