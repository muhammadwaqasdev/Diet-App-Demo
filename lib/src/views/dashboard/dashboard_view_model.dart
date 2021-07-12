import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:stacked/stacked.dart';

import 'widgets/todays_meals/todays_meal_sub_item.dart';

class DashboardViewModel extends BaseViewModel {
  final Animation<double> animation;
  final AnimationController controller;

  DashboardViewModel(this.animation, this.controller);

  List<TodaysMealItemModel> get todaysMeals => [
        TodaysMealItemModel(
            title: "Snacks",
            subTitle: "100 cals, 40p, 60c, 50f",
            mealItems: [
              TodaysMealSubItemModel(
                  title: "Harmburger (Single patty with condiments)",
                  subTitle: "1 sandwich - 2 cals, 124 p, 34.9 c, 45.2 f"),
              TodaysMealSubItemModel(
                  title: "Beef",
                  subTitle:
                      "1 cup, cooked, shredded, - 2 cals, 124 p, 34.9 c, 45.2 f"),
            ]),
        TodaysMealItemModel(
            title: "Lunch",
            subTitle: "100 cals, 40p, 60c, 50f",
            mealItems: [
              TodaysMealSubItemModel(
                  title: "Harmburger (Single patty with condiments)",
                  subTitle: "1 sandwich - 2 cals, 124 p, 34.9 c, 45.2 f"),
              TodaysMealSubItemModel(
                  title: "Beef",
                  subTitle:
                      "1 cup, cooked, shredded, - 2 cals, 124 p, 34.9 c, 45.2 f"),
            ]),
        TodaysMealItemModel(
            title: "Breakfast",
            subTitle: "100 cals, 40p, 60c, 50f",
            mealItems: [
              TodaysMealSubItemModel(
                  title: "Harmburger (Single patty with condiments)",
                  subTitle: "1 sandwich - 2 cals, 124 p, 34.9 c, 45.2 f"),
              TodaysMealSubItemModel(
                  title: "Beef",
                  subTitle:
                      "1 cup, cooked, shredded, - 2 cals, 124 p, 34.9 c, 45.2 f"),
            ])
      ];

  void onDrawerToggleTap() =>
      (animation.value == 0) ? controller.reverse() : controller.forward();
}
