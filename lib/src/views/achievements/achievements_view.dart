import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/dashboard_app_bar.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/page_end_spacer.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/achievements/widgets/color_wide_box.dart';
import 'package:diet_app/src/views/achievements/widgets/counter_progress_bar.dart';
import 'package:diet_app/src/views/dashboard/widgets/daily_stat_item.dart';
import 'package:stacked/stacked.dart';

import 'achievements_view_model.dart';

class AchievementsView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<AchievementsView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AchievementsViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EmptyAppBar(color: Color(0xFFF0F4F5)),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(),
              color: Color(0xFFF0F4F5),
              child: Column(
                children: [
                  VerticalSpacing(10),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: AppBarActionButton(
                          bgColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text('Total Calories',
                            style: context.textTheme().headline5),
                        Text('1635',
                            style: context
                                .textTheme()
                                .headline1
                                ?.copyWith(height: 1.3)),
                        Text('Lorem ipsum dolor sit amet',
                            style: context
                                .textTheme()
                                .headline5
                                ?.copyWith(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  VerticalSpacing(100),
                ],
              ),
            ),
            Column(
              children: [
                Transform.translate(
                  offset: Offset(0.0, -80),
                  child: Container(
                    padding: EdgeInsets.only(left: 25, right: 10),
                    height: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DailyStatItem(
                            height: 140,
                            width: null,
                            progress: 45,
                            total: 115,
                            hideProgressBar: true,
                            title: "Total Protien",
                            lightColor: AppColors.protienLightPurple,
                            darkColor: AppColors.protienPurple,
                            icon: Images.icTotalProtien,
                          ),
                        ),
                        Expanded(
                          child: DailyStatItem(
                            height: 140,
                            width: null,
                            iconPadding: 8,
                            progress: 100,
                            total: 120,
                            hideProgressBar: true,
                            title: "Total Carbs",
                            lightColor: AppColors.carbsLightGreen,
                            darkColor: AppColors.carbsGreen,
                            icon: Images.icTotalCarbs,
                          ),
                        ),
                        Expanded(
                          child: DailyStatItem(
                            height: 140,
                            width: null,
                            progress: 98,
                            total: 150,
                            hideProgressBar: true,
                            title: "Total Fats",
                            lightColor: AppColors.fatsLightBlue,
                            darkColor: AppColors.fatsBlue,
                            icon: Images.icTotalFats,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                VerticalSpacing(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Transform.translate(
                    offset: Offset(0, -80),
                    child: Column(
                      children: [
                        ColorWideBox(
                            color: AppColors.activeLightGreen,
                            leftTitleSet: ColorBoxTitleSet(
                                title: "June 01, 2021",
                                subTitle: "Goal Start Date"),
                            rightTitleSet: ColorBoxTitleSet(
                                title: "4", subTitle: "Total Check Ins")),
                        VerticalSpacing(30),
                        ColorWideBox(
                            bottom: Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              child: CounterProgressBar(
                                  total: 7,
                                  progress: 3,
                                  activeColor: Color(0xFFD59AE2)),
                            ),
                            color: Color(0xFFFBE9FF),
                            dividerColor: Colors.white,
                            leftTitleSet: ColorBoxTitleSet(
                                title: "June 01, 2021",
                                subTitle: "Last Check In"),
                            rightTitleSet: ColorBoxTitleSet(
                                title: "June 27, 2021",
                                subTitle: "Next Check In")),
                        VerticalSpacing(15),
                        Text("7 days until your next check in",
                            style: context.textTheme().subtitle2),
                        VerticalSpacing(100),
                        AppElevatedButton.withIcon(
                          child: "Check In",
                          onTap: () {},
                          icon: Image.asset(Images.icRightArrow),
                        ),
                        PageEndSpacer()
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      viewModelBuilder: () => AchievementsViewModel(),
    );
  }
}
