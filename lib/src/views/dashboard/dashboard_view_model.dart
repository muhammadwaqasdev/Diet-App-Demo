import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:diet_app/src/services/local/local_notification_service.dart';
import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:diet_app/src/shared/video_sheet.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../models/video.dart';
import 'widgets/todays_meals/todays_meal_sub_item.dart';

class DashboardViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  AlarmData? expandedAlarm;

  DrawerContainerController drawerContainerController =
      DrawerContainerController();

  final GoalCreationStepsService _goalService =
      locator<GoalCreationStepsService>();

  final LocalDatabaseService _localDatabaseService =
      locator<LocalDatabaseService>();

  final LocalNotificationService _localNotificationService =
      locator<LocalNotificationService>();

  final AuthService _authService = locator<AuthService>();

  DashboardViewModel({required this.isFromSetup});

  Future<DailyIntake> get _dailyIntakeRecord async =>
      (await _localDatabaseService.intakeDao.getAllIntakes())
          .where((di) => (di.date.day == DateTime.now().day &&
              di.date.month == DateTime.now().month &&
              di.date.year == DateTime.now().year))
          .first;

  late DailyIntake dailyIntake;

  List<TodaysMealItemModel> todaysIntakes = [];

  final bool isFromSetup;

  init(BuildContext context, Screen screen) async {
    if (!isFromSetup) {
      super.init(context, screen);
    } else {
      VideoSheet.show(context, getVideo(Screen.MEAL_PLAN_COMPLETE));
    }
    setBusy(true);
    dailyIntake = (await _dailyIntakeRecord);
    todaysIntakes = dailyIntake.alams
        .where((alarm) => [
              AlarmType.Breakfast,
              AlarmType.Lunch,
              AlarmType.Snacks,
              AlarmType.Dinner
            ].contains(alarm.type))
        .map((alarm) => TodaysMealItemModel(
            dailyIntakeId: dailyIntake.id ?? 0,
            alarm: alarm,
            subTitle:
                "${alarm.totalCalories} cals, ${alarm.totalProteins}p, ${alarm.totalCarbs}c, ${alarm.totalFats}f",
            mealItems: alarm.foods!
                .map((food) => TodaysMealSubItemModel(
                    title: food.foodName ?? "",
                    subTitle:
                        "${(food.foodDescription ?? "").isNotEmpty ? food.foodDescription! + " - " : ""}${food.calories} cals, ${food.protein} p, ${food.carbs} c, ${food.fat} f"))
                .toList()))
        .toList();
    setBusy(false);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalService, _authService];

  void onMealExpansionTap(TodaysMealItemModel mealModel) async {
    if (expandedAlarm == mealModel.alarm) {
      expandedAlarm = null;
    } else {
      expandedAlarm = mealModel.alarm;
    }
    notifyListeners();
  }

  void onMealCompletionTap(TodaysMealItemModel mealModel) async {
    if (mealModel.dailyIntakeId == 0) {
      return;
    }
    var intake = await _localDatabaseService.intakeDao
        .findIntakeById(mealModel.dailyIntakeId);

    var alarmIndex = intake!.alams.indexOf(mealModel.alarm);
    intake.alams[alarmIndex].isDone = !intake.alams[alarmIndex].isDone;

    await _localDatabaseService.intakeDao.updateDailyIntake(intake);
    mealModel.alarm.isDone = !mealModel.alarm.isDone;
    if (mealModel.alarm.isDone) {
      _localNotificationService.cancelAlarm(mealModel.alarm);
    } else {
      _localNotificationService.scheduleSingleAlarm(
          mealModel.dailyIntakeId, mealModel.alarm);
    }
    notifyListeners();
  }
}
