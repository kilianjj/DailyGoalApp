// ignore_for_file: constant_identifier_names
// ignore_for_file: non_constant_identifier_names
import 'package:daily_goal_app/util/goal_tile.dart';
import 'package:hive/hive.dart';
import 'package:daily_goal_app/util/button.dart';

/// database class object for 
var DATABASE = GoalDatabase();

class GoalDatabase {
  /// Hive boxes and key names
  static const String LIGHTMODEBOX = "LIGHT";
  static const String GOALBOX = "GOALS";
  static const String GOALKEY = "goalkey";
  static const String LIGHTMODEKEY = "lightkey";
  static late Box<Goal> GBOX;
  static late Box<bool> LBOX;

  /// load the stored lightmode, defaults to true
  Future<bool> loadLightMode() async {
    return LBOX.get(LIGHTMODEKEY, defaultValue: true)!;
  }

  /// upon changing lightmode, commit that change to Hive database
  void saveLightMode(bool mode) async {
    LBOX.put(LIGHTMODEKEY, mode);
  }

  /// if there are stored goals, load an example one
  void populateInitialGoal() {
    goals = [Goal(task: "Add your own goals!", lastComplete: DateTime.now())];
  }

  /// upon updates to goals, commit those changes to db
  void saveGoals() async {
    await GBOX.clear();
    for (int i = 0; i < goals.length; i++) {
      await GBOX.put(i, goals[i]);
    }
  }

  /// load goals from db when app first starts
  void loadGoals() async {
    goals = GBOX.values.toList();
  }

  /// update streak statuses for goals
  void updateStreaks() {
    for (int i = 0; i < goals.length; i++) {
      timecheck(i, DateTime.now());
    }
  }

  /// holds the goal list while open running
  List<Goal> goals = [];
}
