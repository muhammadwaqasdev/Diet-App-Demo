import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/shared/dashboard_app_bar.dart';
import 'package:diet_app/src/shared/page_end_spacer.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/dashboard/widgets/daily_stat_item.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_drawer.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_header.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_section_title.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:stacked/stacked.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (viewModelContext, model, child) => DrawerContainer(
          controller: model.drawerContainerController,
          drawer: DashboardDrawer(
            onDrawerCloseTap: model.drawerContainerController.toggleDrawer,
            isGoalSetup: true,
          ),
          body: Scaffold(
            appBar: DashboardAppBar(
                onDrawerIconTap: () =>
                    model.drawerContainerController.toggleDrawer()),
            body: Container(
              color: AppColors.primaryBg,
              child: SafeArea(
                child: ListView(
                  children: [
                    VerticalSpacing(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: DashboardHeader(),
                    ),
                    VerticalSpacing(40),
                    Container(
                      padding: const EdgeInsets.only(top: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x05000000),
                            offset: Offset(0, -20),
                            blurRadius: 32,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: DashboardSectionTitle(text: "Daily States"),
                          ),
                          VerticalSpacing(15),
                          SizedBox(
                            height: 160,
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              scrollDirection: Axis.horizontal,
                              children: [
                                DailyStatItem(
                                  progress: 45,
                                  total: 115,
                                  title: "Total Protien",
                                  lightColor: AppColors.protienLightPurple,
                                  darkColor: AppColors.protienPurple,
                                  icon: Images.icTotalProtien,
                                ),
                                DailyStatItem(
                                  iconPadding: 8,
                                  progress: 100,
                                  total: 120,
                                  title: "Total Carbs",
                                  lightColor: AppColors.carbsLightGreen,
                                  darkColor: AppColors.carbsGreen,
                                  icon: Images.icTotalCarbs,
                                ),
                                DailyStatItem(
                                  progress: 98,
                                  total: 150,
                                  title: "Total Fats",
                                  lightColor: AppColors.fatsLightBlue,
                                  darkColor: AppColors.fatsBlue,
                                  icon: Images.icTotalFats,
                                )
                              ],
                            ),
                          ),
                          VerticalSpacing(35),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: DashboardSectionTitle(text: "Today's Meals"),
                          ),
                          VerticalSpacing(10),
                        ],
                      ),
                    ),
                    ...model.todaysMeals
                        .map((todaysMealData) =>
                            TodaysMealItem(itemData: todaysMealData))
                        .toList(),
                    PageEndSpacer()
                  ],
                ),
              ),
            ),
          )),
      viewModelBuilder: () => DashboardViewModel(),
    );
  }
}
