import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:diet_app/src/services/remote/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<dynamic> onReceiveNotification(
    int id, String? title, String? body, String? payload) async {
  print(title);
}

Future<dynamic> onSelectNotification(String? payload) async {
  var payloadSplit = (payload ?? "").split("|");
  int notificationId = int.parse(payloadSplit.last);
  int dateMills = int.parse(payloadSplit.first);
  FlutterLocalNotificationsPlugin().cancel(notificationId);
}

class LocalNotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isInitialized = false;
  static const int alarmDays = 7;

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onReceiveNotification);
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  schedule(Goal goal) async {
    makeKey(AlarmData alarm) =>
        "${alarm.time.hour}:${alarm.time.minute}-${describeEnum(alarm.type)}";
    var currentDate = tz.TZDateTime.now(tz.local);
    var db = locator<LocalDatabaseService>().db;
    var api = locator<ApiService>();
    var perMealMaxCalorieLimit =
        goal.calculatedCaloriesIntake / goal.meals.value;
    var perMealCalorieLimit = perMealMaxCalorieLimit / 2;
    var notificationId = 0;
    Map<String, List<Food>> foods = {};
    Map<AlarmType, double> limitSections = {};
    var goalService = locator<GoalCreationStepsService>();
    var dislikedMeals = [...goal.dislikedMealIds];
    goalService.loadingStep++;
    goalService.loadingStep++;
    for (var alarm in goal.alarmData) {
      if (!alarm.isMeal) {
        continue;
      }
      if (!foods.containsKey(makeKey(alarm))) {
        foods[makeKey(alarm)] = [];
      }
      List<Food> foodsRes = [];
      int divVal = 0;

      while (foodsRes.isEmpty) {
        var limit = perMealCalorieLimit / (++divVal);
        if ((limitSections[alarm.type] ?? 0) > 0) {
          limit = limitSections[alarm.type] ?? 0;
        }
        foodsRes = (await api.getFoods(describeEnum(alarm.type),
                dislikedMeals: dislikedMeals, minCalorieLimit: limit)) ??
            [];

        if (foodsRes.isNotEmpty) {
          goalService.loadingStep++;
          limitSections[alarm.type] = limit;
          //dislikedMeals.addAll(foods.values.expand((element) => element).map((e) => int.parse(e.foodId ?? "0")));
        }
      }
      foods[makeKey(alarm)]?.addAll(foodsRes);
    }
    await db.dailyIntakeDao.clearIntakes();
    for (int i = 1; i <= alarmDays; i++) {
      for (int alarmIndex = 0;
          alarmIndex < goal.alarmData.length;
          alarmIndex++) {
        var alarm = goal.alarmData[alarmIndex];

        var notiTime = currentDate.add(Duration(days: i - 1));
        if (notiTime.hour > 0) {
          notiTime = notiTime.subtract(Duration(hours: currentDate.hour));
        }
        if (notiTime.minute > 0) {
          notiTime = notiTime.subtract(Duration(minutes: currentDate.minute));
        }
        if (notiTime.second > 0) {
          notiTime = notiTime.subtract(Duration(seconds: currentDate.second));
        }
        if (notiTime.millisecond > 0) {
          notiTime = notiTime.subtract(Duration(milliseconds: 0));
        }
        if (notiTime.microsecond > 0) {
          notiTime = notiTime.subtract(Duration(microseconds: 0));
        }

        var alarmDate = notiTime.add(Duration());

        if (alarm.isMeal) {
          var foodsRes = foods[makeKey(alarm)]!
              .where((food) =>
                  !dislikedMeals.contains(int.parse(food.foodId ?? "0")))
              .toList();
          if (foodsRes != null && foodsRes.length - 1 >= i) {
            alarm.foods = [];
            int foodIndex = 0;
            while (alarm.totalCalories < perMealMaxCalorieLimit) {
              var food = foodsRes[foodIndex++];
              alarm.foods.add(food);
              dislikedMeals.add(int.parse(food.foodId ?? "0"));
            }
          }

          notiTime = notiTime.add(
              Duration(hours: alarm.time.hour, minutes: alarm.time.minute));
          if (!currentDate.isBefore(notiTime)) {
            notiTime = notiTime.add(Duration(days: 1));
          }

          await flutterLocalNotificationsPlugin.zonedSchedule(
              ++notificationId,
              '${describeEnum(alarm.type)} Meal Alarm!',
              'You need to take your meal ${alarm.foods.map((meal) => meal.foodName).join(", ")} now!',
              notiTime,
              const NotificationDetails(
                  iOS: IOSNotificationDetails(
                      presentAlert: false, badgeNumber: 1),
                  android: AndroidNotificationDetails(
                      'meals_reminder_channel',
                      'Meals reminder channel',
                      'To suggest meals for your daily calorie intake!',
                      priority: Priority.max,
                      importance: Importance.max,
                      autoCancel: false,
                      ongoing: true)),
              androidAllowWhileIdle: true,
              payload: "${notiTime.millisecondsSinceEpoch}|$notificationId",
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);
          alarm.notificationId = notificationId;
        }
        goal.alarmData[alarmIndex] = alarm;

        if (alarm.type == AlarmType.Sleep) {
          await db.dailyIntakeDao
              .insertDailyIntake(DailyIntake(null, alarmDate, goal.alarmData));
        }
      }
    }
    await Future.delayed(Duration(milliseconds: 2000));
    goalService.loadingStep++;
  }

  cancelAlarm(AlarmData alarm) {
    flutterLocalNotificationsPlugin.cancel(alarm.notificationId);
  }

  scheduleSingleAlarm(int dailyIntakeId, AlarmData alarm) async {
    DailyIntake? dailyIntake = await locator<LocalDatabaseService>()
        .db
        .dailyIntakeDao
        .findIntakeById(dailyIntakeId);
    if (dailyIntake == null) {
      return;
    }
    var notiDateTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
        tz.local, dailyIntake.date.setTime(alarm.time).millisecondsSinceEpoch);
    var notiId = DateTime.now().millisecondsSinceEpoch;
    flutterLocalNotificationsPlugin.cancel(alarm.notificationId);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notiId,
        '${describeEnum(alarm.type)} Meal Alarm!',
        'You need to take your meal ${alarm.foods.map((meal) => meal.foodName).join(", ")} now!',
        notiDateTime,
        const NotificationDetails(
            iOS: IOSNotificationDetails(presentAlert: false, badgeNumber: 1),
            android: AndroidNotificationDetails(
                'meals_reminder_channel',
                'Meals reminder channel',
                'To suggest meals for your daily calorie intake!',
                priority: Priority.max,
                importance: Importance.max,
                autoCancel: false,
                ongoing: true)),
        androidAllowWhileIdle: true,
        payload: "${dailyIntake.date.millisecondsSinceEpoch}|$notiId",
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
