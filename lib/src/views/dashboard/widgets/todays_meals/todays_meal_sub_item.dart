import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';

class TodaysMealSubItemModel {
  final String title;
  final String subTitle;

  TodaysMealSubItemModel({required this.title, required this.subTitle});
}

class TodaysMealSubItem extends StatelessWidget {
  final TodaysMealSubItemModel itemData;

  const TodaysMealSubItem({required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenSize().width.percent(100),
      padding: EdgeInsets.only(bottom: 7, top: 7),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.greyBorder, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(itemData.title, style: context.textTheme().headline6),
          Text(itemData.subTitle,
              style: context.textTheme().bodyText1?.copyWith(
                  color: AppColors.greySubTitle,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
