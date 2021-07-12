import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/shared/goal_step_progress_bar.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';

class DailyStatItem extends StatelessWidget {
  final Color lightColor;
  final Color darkColor;
  final String icon;
  final double iconPadding;
  final String title;
  final int progress;
  final int total;
  final double? width;
  final double? height;
  final bool hideProgressBar;

  const DailyStatItem(
      {required this.lightColor,
      required this.darkColor,
      required this.icon,
      required this.title,
      this.width = 140,
      this.height,
      this.hideProgressBar = false,
      this.iconPadding = 7,
      this.progress = 0,
      this.total = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: lightColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            padding: EdgeInsets.all(iconPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: darkColor,
            ),
            child: Image.asset(icon, fit: BoxFit.contain),
          ),
          VerticalSpacing(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$progress",
                style: context
                    .textTheme()
                    .headline3
                    ?.copyWith(color: AppColors.primary, height: 1.10),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 3),
                child: Text("$total",
                    style: context
                        .textTheme()
                        .headline6
                        ?.copyWith(color: darkColor)),
              ),
            ],
          ),
          Text(title,
              style: context
                  .textTheme()
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.normal, height: 1.20)),
          if (!hideProgressBar) ...[
            VerticalSpacing(10),
            GoalStepProgressBar(
              progress: progress,
              total: total,
              color: darkColor,
              bgColor: Colors.white,
              height: 3,
            )
          ]
        ],
      ),
    );
  }
}
