import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

import 'widgets/todays_meals/todays_meal_sub_item.dart';

class DashboardViewModel extends ReactiveViewModel {
  DrawerContainerController drawerContainerController =
      DrawerContainerController();

  final GoalCreationStepsService _goalService =
      locator<GoalCreationStepsService>();

  Goal get goal => _goalService.goal;

  List<TodaysMealItemModel> get todaysMeals => goal.alarmData
      .where((alarm) => [
            AlarmType.Breakfast,
            AlarmType.Lunch,
            AlarmType.Snacks,
            AlarmType.Dinner
          ].contains(alarm.type))
      .map((alarm) => TodaysMealItemModel(
              title: describeEnum(alarm.type),
              subTitle: "100 cals, 40p, 60c, 50f",
              mealItems: [
                TodaysMealSubItemModel(
                    title: "Harmburger (Single patty with condiments)",
                    subTitle: "1 sandwich - 2 cals, 124 p, 34.9 c, 45.2 f"),
                TodaysMealSubItemModel(
                    title: "Beef",
                    subTitle:
                        "1 cup, cooked, shredded, - 2 cals, 124 p, 34.9 c, 45.2 f"),
              ]))
      .toList();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_goalService];
}
