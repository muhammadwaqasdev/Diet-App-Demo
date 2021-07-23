import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/shared/completed_check.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class TodaysMealItemHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isCompleted;
  final bool isExpanded;
  final GestureTapCallback? onCompleteTap;

  const TodaysMealItemHeader(
      {required this.title,
      required this.subTitle,
      this.isCompleted = false,
      this.isExpanded = false,
      this.onCompleteTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: isCompleted ? .41 : 1,
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary,
            ),
            child: Image.asset(Images.icReminder),
          ),
        ),
        HorizontalSpacing(10),
        Expanded(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: isCompleted ? .41 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme().headline5),
                Text(subTitle,
                    style: context
                        .textTheme()
                        .headline6
                        ?.copyWith(color: AppColors.greySubTitle)),
              ],
            ),
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: isCompleted ? .41 : 1,
          child: Image.asset(isExpanded ? Images.icArrowUp : Images.icArrowDown,
              width: 20, height: 10),
        ),
        HorizontalSpacing(15),
        GestureDetector(
            child: CompletedCheck(isChecked: isCompleted),
            onTap: onCompleteTap),
      ],
    );
  }
}
