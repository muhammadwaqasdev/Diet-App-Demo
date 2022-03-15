import 'package:diet_app/src/models/goal.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "daily_intake")
class DailyIntake {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final DateTime date;

  final List<AlarmData> alams;

  List<AlarmData> get doneAlarms =>
      alams.where((alarm) => alarm.isDone).toList();

  int get totalCalories =>
      alams.map((alarm) => alarm.totalCalories).reduce((v1, v2) => v1 + v2);

  int get totalProtein =>
      alams.map((alarm) => alarm.totalProteins).reduce((v1, v2) => v1 + v2);

  int get totalCarbs =>
      alams.map((alarm) => alarm.totalCarbs).reduce((v1, v2) => v1 + v2);

  int get totalFats =>
      alams.map((alarm) => alarm.totalFats).reduce((v1, v2) => v1 + v2);

  int get consumedCalories => doneAlarms.isEmpty
      ? 0
      : doneAlarms
          .map((alarm) => alarm.totalCalories)
          .reduce((v1, v2) => v1 + v2);

  int get consumedProtein => doneAlarms.isEmpty
      ? 0
      : doneAlarms
          .map((alarm) => alarm.totalProteins)
          .reduce((v1, v2) => v1 + v2);

  int get consumedCarbs => doneAlarms.isEmpty
      ? 0
      : doneAlarms.map((alarm) => alarm.totalCarbs).reduce((v1, v2) => v1 + v2);

  int get consumedFats => doneAlarms.isEmpty
      ? 0
      : doneAlarms.map((alarm) => alarm.totalFats).reduce((v1, v2) => v1 + v2);

  DailyIntake(this.id, this.date, this.alams);
}
