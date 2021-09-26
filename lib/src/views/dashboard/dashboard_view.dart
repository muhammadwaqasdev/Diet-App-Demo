import 'dart:io';

import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/shared/dashboard_app_bar.dart';
import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:diet_app/src/shared/loading_indicator.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/dashboard/widgets/daily_stat_item.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_drawer.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_header.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_section_title.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (viewModelContext, model, child) => DrawerContainer(
          enableSwipe: true,
          controller: model.drawerContainerController,
          drawer: DashboardDrawer(
            onDrawerCloseTap: model.drawerContainerController.toggleDrawer,
            isGoalSetup: true,
          ),
          body: Scaffold(
            appBar: DashboardAppBar(
                onDrawerIconTap: () =>
                    model.drawerContainerController.toggleDrawer()),
            body: model.isBusy
                ? Center(child: LoadingIndicator())
                : model.dailyIntake.alams.isEmpty
                    ? Center(
                        child: Text("No daily intakes ready yet!",
                            style: context.textTheme().headline5))
                    : Container(
                        color: AppColors.primaryBg,
                        child: SafeArea(
                          bottom: false,
                          child: ListView(
                            padding: EdgeInsets.only(
                                bottom: Platform.isIOS ? 10 : 30),
                            children: [
                              VerticalSpacing(20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: DashboardHeader(model.dailyIntake),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: DashboardSectionTitle(
                                          text: "Daily States"),
                                    ),
                                    VerticalSpacing(15),
                                    SizedBox(
                                      height: 160,
                                      child: ListView(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24),
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          DailyStatItem(
                                            progress: model
                                                .dailyIntake.consumedProtein,
                                            total:
                                                model.dailyIntake.totalProtein,
                                            title: "Total Protein",
                                            lightColor:
                                                AppColors.protienLightPurple,
                                            darkColor: AppColors.protienPurple,
                                            icon: Images.icTotalProtien,
                                          ),
                                          DailyStatItem(
                                            iconPadding: 8,
                                            progress:
                                                model.dailyIntake.consumedCarbs,
                                            total: model.dailyIntake.totalCarbs,
                                            title: "Total Carbs",
                                            lightColor:
                                                AppColors.carbsLightGreen,
                                            darkColor: AppColors.carbsGreen,
                                            icon: Images.icTotalCarbs,
                                          ),
                                          DailyStatItem(
                                            progress:
                                                model.dailyIntake.consumedFats,
                                            total: model.dailyIntake.totalFats,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: DashboardSectionTitle(
                                          text: "Today's Meals"),
                                    ),
                                    VerticalSpacing(10),
                                  ],
                                ),
                              ),
                              ...model.todaysIntakes
                                  .map((todaysMealData) => TodaysMealItem(
                                      isExpanded: model.expandedAlarm ==
                                          todaysMealData.alarm,
                                      itemData: todaysMealData,
                                      onExpansionTap: model.onMealExpansionTap,
                                      onCompleteTap: model.onMealCompletionTap))
                                  .toList(),
                              //PageEndSpacer()
                            ],
                          ),
                        ),
                      ),
          )),
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}
