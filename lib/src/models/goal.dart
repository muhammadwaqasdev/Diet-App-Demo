import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/app_user.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

enum GoalTarget { Weight_Loss, Gain_Weight, Maintain }
enum PreferredDiet { Keto, Balanced, Low_Carbs }
enum AlarmType { Wakeup, Breakfast, Lunch, Snacks, Dinner, Sleep }
enum Macros { Protein, Carbs, Fat }

class AlarmData {
  final AlarmType type;
  TimeOfDay time;
  bool isDone;
  ReactiveList<Food>? foods;
  int notificationId;

  List<Food> get proteins => foods?.where((food) => food.macro == Macros.Protein).toList() ?? [];
  List<Food> get carbs => foods?.where((food) => food.macro == Macros.Carbs).toList() ?? [];
  List<Food> get fats => foods?.where((food) => food.macro == Macros.Fat).toList() ?? [];

  int get totalCalories =>
      foods!.isEmpty
          ? 0
          : foods!.map((food) => food.calories).reduce((v1, v2) => v1 + v2);

  int get totalFats =>
      foods!.isEmpty
          ? 0
          : foods!.map((food) => food.fat.round()).reduce((v1, v2) => v1 + v2);

  int get totalProteins =>
      foods!.isEmpty
          ? 0
          : foods!.map((food) => food.protein.round()).reduce((v1, v2) =>
      v1 + v2);

  int get totalCarbs =>
      foods!.isEmpty
          ? 0
          : foods!.map((food) => food.carbs.round()).reduce((v1, v2) => v1 + v2);

  bool isFullFilled(Goal goal){
    if(goal.isManualMacrosEntry.value){
      return goal.macroProtein.value <= totalProteins && goal.macroFat.value <= totalFats && goal.macroCarbs.value <= totalCarbs;
    }
    return (goal.caloriesIntake / goal.meals.value) <= totalCalories;
  }

  bool get isMeal => (type != AlarmType.Wakeup && type != AlarmType.Sleep);

  AlarmData({required this.type,
    required this.time,
    this.notificationId = 0,
    this.foods,
    this.isDone = false}){
    if(this.foods == null){
      this.foods = ReactiveList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "foods": foods!.map((e) => e.toJson()).toList(),
      "type": describeEnum(this.type),
      "notification_id": notificationId,
      "is_done": isDone,
      "time":
      "${this.time.hour < 10 ? '0${this.time.hour}' : this.time.hour}:${this
          .time.minute < 10 ? "0${this.time.minute}" : this.time.minute}",
    };
  }

  factory AlarmData.fromJson(Map<String, dynamic> json) {
    List<String> timeElements = (json["time"] as String).split(":");
    ReactiveList<Food> foods = ReactiveList();
    if (json['foods'] != null) {
      for (var food in (json['foods'] as List<dynamic>)) {
        foods.add(Food.fromJson(food));
      }
    }
    return AlarmData(
      notificationId: json['notification_id'],
      isDone: json['is_done'],
      foods: foods,
      type: AlarmType.values[AlarmType.values
          .map((e) => describeEnum(e))
          .toList()
          .indexOf(json["type"])],
      time: TimeOfDay(
          hour: int.parse(timeElements.first),
          minute: int.parse(timeElements.last)),
    );
  }

  AlarmData copyWith({
    AlarmType? type,
    TimeOfDay? time,
    bool? isDone,
    ReactiveList<Food>? foods,
    int? notificationId,
  }) {
    return AlarmData(
      type: type ?? this.type,
      time: time ?? this.time,
      isDone: isDone ?? this.isDone,
      notificationId: notificationId ?? this.notificationId,
      foods: foods ?? this.foods,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AlarmData &&
          other.time.hour == time.hour &&
          other.time.minute == time.minute &&
          other.type == type;

  @override
  int get hashCode => type.hashCode;
}

class Goal {
  static Map<int, List<AlarmData>> get mealSets =>
      {
        5: [
          AlarmData(
              type: AlarmType.Wakeup, time: TimeOfDay(hour: 8, minute: 0)),
          AlarmData(
              type: AlarmType.Breakfast, time: TimeOfDay(hour: 9, minute: 0)),
          AlarmData(
              type: AlarmType.Snacks, time: TimeOfDay(hour: 11, minute: 0)),
          AlarmData(
              type: AlarmType.Lunch, time: TimeOfDay(hour: 13, minute: 0)),
          AlarmData(
              type: AlarmType.Snacks, time: TimeOfDay(hour: 16, minute: 0)),
          AlarmData(
              type: AlarmType.Dinner, time: TimeOfDay(hour: 20, minute: 0)),
          AlarmData(
              type: AlarmType.Sleep, time: TimeOfDay(hour: 21, minute: 0)),
        ],
        6: [
          AlarmData(
              type: AlarmType.Wakeup, time: TimeOfDay(hour: 8, minute: 0)),
          AlarmData(
              type: AlarmType.Breakfast, time: TimeOfDay(hour: 9, minute: 0)),
          AlarmData(
              type: AlarmType.Snacks, time: TimeOfDay(hour: 11, minute: 0)),
          AlarmData(
              type: AlarmType.Lunch, time: TimeOfDay(hour: 13, minute: 0)),
          AlarmData(
              type: AlarmType.Snacks, time: TimeOfDay(hour: 16, minute: 0)),
          AlarmData(
              type: AlarmType.Dinner, time: TimeOfDay(hour: 20, minute: 0)),
          AlarmData(
              type: AlarmType.Snacks, time: TimeOfDay(hour: 21, minute: 0)),
          AlarmData(
              type: AlarmType.Sleep, time: TimeOfDay(hour: 22, minute: 0)),
        ]
      };

  String id;
  String uid;
  final ReactiveValue<int> heightFt;
  final ReactiveValue<int> heightIn;
  final ReactiveValue<double> weight;
  final ReactiveValue<double> activityLevel;
  final ReactiveValue<GoalTarget> goalTarget;
  final ReactiveValue<double> targetWeight;
  final ReactiveValue<int> targetSleep;
  final ReactiveValue<int> targetStress;
  final ReactiveValue<int> meals;
  final ReactiveValue<PreferredDiet> preferredDiet;
  final ReactiveList<AlarmData> alarmData;
  final ReactiveValue<double> additionalIntakePercentage;
  final ReactiveValue<double> lastCalculatedIntake;
  final ReactiveValue<bool> isManualMacrosEntry;
  final ReactiveValue<double> macroProtein;
  final ReactiveValue<double> macroCarbs;
  final ReactiveValue<double> macroFat;

  AlarmData get wakeUpAlarm =>
      alarmData
          .where((alarm) => alarm.type == AlarmType.Wakeup)
          .first;

  AlarmData get breakfastAlarm =>
      alarmData
          .where((alarm) => alarm.type == AlarmType.Breakfast)
          .first;

  AlarmData get lunchAlarm =>
      alarmData
          .where((alarm) => alarm.type == AlarmType.Lunch)
          .first;

  AlarmData get dinnerAlarm =>
      alarmData
          .where((alarm) => alarm.type == AlarmType.Dinner)
          .first;

  AlarmData get sleepAlarm =>
      alarmData
          .where((alarm) => alarm.type == AlarmType.Sleep)
          .first;
  final ReactiveList<String> likedMeals;

  List<int> get likedMealIds =>
      likedMeals.map((mealIdStr) => int.parse(mealIdStr)).toList();

  double get finalHeight =>
      ((heightFt.value * 30.48) + (heightIn.value * 2.54));

  //10 x 175lbs + 6.25 x 70inchs - 5 x 31 (years old) + 5= 2,037.5 BMR
  double get _maleBMR =>
      (10 * weight.value) +
          finalHeight -
          (5 * locator<AuthService>().user!.age) +
          5;

  double get _femaleBMR =>
      (10 * weight.value) +
          finalHeight -
          (5 * locator<AuthService>().user!.age) -
          161;

  double get calculatedBMR =>
      locator<AuthService>().user!.userGender == Gender.MALE
          ? _maleBMR
          : _femaleBMR;

  double get _goalCalculatedSumValue =>
      goalTarget.value == GoalTarget.Maintain
          ? 0
          : goalTarget.value == GoalTarget.Gain_Weight
          ? (_caloriesIntakeBase).percent(15)
          : (_caloriesIntakeBase).percent(-15);

  double get _caloriesIntakeBase => (calculatedBMR * activityLevel.value);

  // For manual macros entry, the below url is the source for formula from macros to kcal
  /*
    Carbohydrate: 4 kcal * 23 = 92 kcal

    Protein: 4 kcal * 4 = 16 kcal

    Fat: 9 kcal * 9 = 81 kcal

    Total: 92 kcal + 16 kcal + 81 kcal = 189 kcal
  */
  //https://www.omnicalculator.com/conversion/grams-to-calories

  double get caloriesIntake => isManualMacrosEntry.value ? (
      (4 * macroCarbs.value) + (4 * macroProtein.value) + (9 * macroFat.value)
  ) : (_caloriesIntakeBase + _goalCalculatedSumValue);

  Future<double> get caloriesIntakePerMeal async => caloriesIntake / (await meals.values.length);


  double get calculatedCaloriesIntake {
    var baseIntake = caloriesIntake;
    if (lastCalculatedIntake.value > 0) {
      baseIntake = lastCalculatedIntake.value;
    }

    if (additionalIntakePercentage.value < 0) {
      lastCalculatedIntake.value =
          baseIntake - (baseIntake.percent(additionalIntakePercentage.value));
    } else if (additionalIntakePercentage.value > 0) {
      lastCalculatedIntake.value =
          baseIntake + (baseIntake.percent(additionalIntakePercentage.value));
    } else {
      lastCalculatedIntake.value = baseIntake;
    }
    return lastCalculatedIntake.value;
  }

  Goal({required this.heightFt,
    required this.heightIn,
    required this.weight,
    required this.activityLevel,
    required this.goalTarget,
    required this.targetWeight,
    required this.targetSleep,
    required this.targetStress,
    required this.meals,
    required this.preferredDiet,
    required this.alarmData,
    required this.likedMeals,
    required this.uid,
    required this.id,
    required this.additionalIntakePercentage,
    required this.lastCalculatedIntake,
    required this.isManualMacrosEntry,
    required this.macroProtein,
    required this.macroCarbs,
    required this.macroFat,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "uid": this.uid,
      "heightFt": this.heightFt.value,
      "heightIn": this.heightIn.value,
      "weight": this.weight.value,
      "activityLevel": this.activityLevel.value,
      "goalTarget": describeEnum(this.goalTarget.value),
      "targetWeight": this.targetWeight.value,
      "targetSleep": this.targetSleep.value,
      "targetStress": this.targetStress.value,
      "meals": this.meals.value,
      "preferredDiet": describeEnum(this.preferredDiet.value),
      "alarmData": this.alarmData.map((alarm) => alarm.toJson()).toList(),
      "likedMeals": this.likedMeals,
      "lastCalculatedIntake": this.calculatedCaloriesIntake,
      "isManualMacrosEntry": this.isManualMacrosEntry.value,
      "macroProtein": this.macroProtein.value,
      "macroCarbs": this.macroCarbs.value,
      "macroFat": this.macroFat.value,
    };
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
        id: json['id'],
        uid: json["uid"],
        heightFt: ReactiveValue<int>(json["heightFt"]),
        heightIn: ReactiveValue<int>(json["heightIn"]),
        weight: ReactiveValue<double>(json["weight"]),
        activityLevel: ReactiveValue<double>(json["activityLevel"]),
        goalTarget: ReactiveValue<GoalTarget>(
            GoalTarget.values[GoalTarget.values
                .map((e) => describeEnum(e))
                .toList()
                .indexOf(json["goalTarget"])]),
        targetWeight: ReactiveValue<double>(json["targetWeight"]),
        targetSleep: ReactiveValue<int>(json["targetSleep"]),
        targetStress: ReactiveValue<int>(json["targetStress"]),
        meals: ReactiveValue<int>(json["meals"]),
        preferredDiet: ReactiveValue<PreferredDiet>(PreferredDiet.values[
        PreferredDiet.values
            .map((e) => describeEnum(e))
            .toList()
            .indexOf(json["preferredDiet"])]),
        alarmData: ReactiveList<AlarmData>.from(
            (json["alarmData"] as List<dynamic>)
                .map((e) => AlarmData.fromJson(e))),
        likedMeals: ReactiveList<String>.from(
            (json["likedMeals"] as List<dynamic>)
                .map((e) => e as String)
                .toList()),
        additionalIntakePercentage: ReactiveValue(0),
        lastCalculatedIntake: ReactiveValue<double>(
            json["lastCalculatedIntake"]),
        isManualMacrosEntry: ReactiveValue<bool>(
            json['isManualMacrosEntry'] ?? false),
        macroProtein: ReactiveValue<double>(
            json['macroProtein'] ?? 0),
        macroCarbs: ReactiveValue<double>(
            json['macroCarbs'] ?? 0),
        macroFat: ReactiveValue<double>(
            json['macroFat'] ?? 0)
    );
  }
//
}
