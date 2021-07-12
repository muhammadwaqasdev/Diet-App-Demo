import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader();

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
                Text("2,000",
                    style: context
                        .textTheme()
                        .headline2
                        ?.copyWith(fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 7, left: 5),
                  child: Text(
                    "3,500",
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
          percent: .85,
          backgroundColor: Colors.transparent,
          center: new Text("85%",
              style: context.textTheme().button?.copyWith(color: Colors.black)),
          progressColor: AppColors.progressGreen,
        )
      ],
    );
  }
}
