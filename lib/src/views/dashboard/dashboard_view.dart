import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/shared/dashboard_app_bar.dart';
import 'package:flutter_starter_app/src/shared/page_end_spacer.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/views/dashboard/widgets/daily_stat_item.dart';
import 'package:flutter_starter_app/src/views/dashboard/widgets/dashboard_drawer.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/views/dashboard/widgets/dashboard_header.dart';
import 'package:flutter_starter_app/src/views/dashboard/widgets/dashboard_section_title.dart';
import 'package:flutter_starter_app/src/views/dashboard/widgets/todays_meals/todays_meal_item.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = new AnimationController(
        duration: Duration(milliseconds: 250), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: -100.0, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuint));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (viewModelContext, model, child) => Transform.translate(
        offset: Offset(animation.value, 0),
        child: SizedBox(
          width: context.screenSize().width + 100,
          child: Stack(
            children: [
              DashboardDrawer(
                onDrawerCloseTap: model.onDrawerToggleTap,
              ),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                  int sensitivity = 8;
                  if (details.delta.dx > sensitivity) {
                    // Right Swipe
                    controller.forward();
                  } else if (details.delta.dx < -sensitivity) {
                    //Left Swipe
                    controller.reverse();
                  }
                },
                child: Transform.translate(
                  offset: Offset(100, 0),
                  child: SizedBox(
                    width: context.screenSize().width,
                    height: context.screenSize().height,
                    child: Scaffold(
                      appBar: DashboardAppBar(
                          onDrawerIconTap: model.onDrawerToggleTap),
                      body: Container(
                        color: AppColors.primaryBg,
                        child: SafeArea(
                          child: ListView(
                            children: [
                              VerticalSpacing(20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
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
                                            progress: 45,
                                            total: 115,
                                            title: "Total Protien",
                                            lightColor:
                                                AppColors.protienLightPurple,
                                            darkColor: AppColors.protienPurple,
                                            icon: Images.icTotalProtien,
                                          ),
                                          DailyStatItem(
                                            iconPadding: 8,
                                            progress: 100,
                                            total: 120,
                                            title: "Total Carbs",
                                            lightColor:
                                                AppColors.carbsLightGreen,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: DashboardSectionTitle(
                                          text: "Today's Meals"),
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => DashboardViewModel(animation, controller),
    );
  }
}
