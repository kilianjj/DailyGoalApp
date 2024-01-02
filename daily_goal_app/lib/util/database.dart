// ignore_for_file: constant_identifier_names
import 'package:daily_goal_app/util/goal_tile.dart';
// ignore_for_file: non_constant_identifier_names
import 'package:hive/hive.dart';
import 'package:daily_goal_app/util/button.dart';

var DATABASE = GoalDatabase();

class GoalDatabase {
  /// Hive box and key names
  static const String LIGHTMODEBOX = "LIGHT";
  static const String GOALBOX = "GOALS";
  static const String GOALKEY = "goalkey";
  static const String LIGHTMODEKEY = "lightkey";
  static late Box<Goal> GBOX;
  static late Box<bool> LBOX;

  Future<bool> loadLightMode() async {
    return LBOX.get(LIGHTMODEKEY, defaultValue: true)!;
  }

  void saveLightMode(bool mode) async {
    LBOX.put(LIGHTMODEKEY, mode);
  }

  void populateInitialGoal() {
    goals = [Goal(task: "Add your own goals!", lastComplete: DateTime.now())];
  }

  void saveGoals() async {
    await GBOX.clear();
    for (int i = 0; i < goals.length; i++) {
      await GBOX.put(i, goals[i]);
    }
  }

  void loadGoals() async {
    goals = GBOX.values.toList();
  }

  void updateStreaks() {
    for (int i = 0; i < goals.length; i++) {
      timecheck(i, DateTime.now());
    }
  }

  List<Goal> goals = [];
}
