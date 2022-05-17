import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardHeader extends StatelessWidget {
  final DailyIntake dailyIntake;

  const DashboardHeader(this.dailyIntake);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Calories", style: context.textTheme().headline5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${dailyIntake.consumedCalories}",
                    style: context
                        .textTheme()
                        .headline2
                        ?.copyWith(fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 7, left: 5),
                  child: Text(
                    "${dailyIntake.totalCalories}",
                    style: context
                        .textTheme()
                        .button
                        ?.copyWith(color: AppColors.progressGreen),
                  ),
                )
              ],
            ),
            Text("Lorem ipsum dolor sit amet",
                style: context
                    .textTheme()
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.normal))
          ],
        )),
        new CircularPercentIndicator(
          radius: 84.0,
          lineWidth: 5.0,
          percent: ((dailyIntake.consumedCalories / dailyIntake.totalCalories) *
                  100) /
              100,
          backgroundColor: Colors.grey.withOpacity(.3),
          center: new Text(
              "${((dailyIntake.consumedCalories / dailyIntake.totalCalories) * 100).round()}%",
              style: context.textTheme().button?.copyWith(color: Colors.black)),
          progressColor: AppColors.progressGreen,
        )
      ],
    );
  }
}
