import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:stacked/stacked.dart';

import 'widgets/todays_meals/todays_meal_sub_item.dart';

class DashboardViewModel extends BaseViewModel {
  DrawerContainerController drawerContainerController =
      DrawerContainerController();

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
}
