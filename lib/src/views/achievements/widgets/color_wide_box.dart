import 'package:flutter/material.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/styles/app_colors.dart';

class ColorBoxTitleSet {
  final String title;
  final String subTitle;

  ColorBoxTitleSet({required this.title, required this.subTitle});
}

class ColorWideBox extends StatelessWidget {
  final Color color;
  final Color dividerColor;
  final ColorBoxTitleSet leftTitleSet;
  final ColorBoxTitleSet rightTitleSet;
  final Widget? bottom;

  const ColorWideBox(
      {required this.color,
      this.dividerColor = AppColors.primary,
      required this.leftTitleSet,
      required this.rightTitleSet,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 17.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(leftTitleSet.subTitle,
                        style: context.textTheme().headline6?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: AppColors.primary)),
                    Text(leftTitleSet.title,
                        style: context
                            .textTheme()
                            .headline3
                            ?.copyWith(fontSize: 18, color: AppColors.primary))
                  ],
                ),
              ),
              Container(
                height: 43,
                width: 1,
                color: dividerColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(rightTitleSet.subTitle,
                        style: context.textTheme().headline6?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: AppColors.primary)),
                    Text(rightTitleSet.title,
                        style: context
                            .textTheme()
                            .headline3
                            ?.copyWith(fontSize: 18, color: AppColors.primary))
                  ],
                ),
              )
            ],
          ),
          if (bottom != null) bottom!
        ],
      ),
    );
  }
}
