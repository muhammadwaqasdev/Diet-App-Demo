import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item_header.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_sub_item.dart';

class TodaysMealItemModel {
  final int dailyIntakeId;
  final AlarmData alarm;
  final String subTitle;
  bool get isCompleted => alarm.isDone;
  bool get isTimePassed =>
      DateTime.now().setTime(alarm.time).difference(DateTime.now()).inSeconds <
      0;
  final List<TodaysMealSubItemModel> mealItems;

  const TodaysMealItemModel(
      {required this.dailyIntakeId,
      required this.alarm,
      required this.subTitle,
      this.mealItems = const []});
}

class TodaysMealItem extends StatelessWidget {
  final TodaysMealItemModel itemData;
  final bool isExpanded;
  final ValueChanged<TodaysMealItemModel> onExpansionTap;
  final ValueChanged<TodaysMealItemModel> onCompleteTap;

  const TodaysMealItem(
      {required this.itemData,
      required this.onExpansionTap,
      this.isExpanded = false,
      required this.onCompleteTap});

  void toggleExpansion() async {
    onExpansionTap(itemData);
    //_additionalDelayFix();
  }

  void toggleCompletion() async {
    // if (itemData.isCompleted) {
    //   return;
    // }
    onCompleteTap(itemData);
    //_additionalDelayFix();
  }

  _additionalDelayFix() async {
    //await Future.delayed(Duration(milliseconds: 100));
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 250),
      child: Container(
        height: isExpanded ? null : 85,
        //duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 17, horizontal: 24),
        decoration: BoxDecoration(
          color: isExpanded ? Colors.white : Colors.transparent,
          border: Border(
              bottom:
                  BorderSide(color: AppColors.greyDarkBgBorderColor, width: 1)),
          boxShadow: [
            BoxShadow(
              color: isExpanded ? Color(0x14000000) : Colors.transparent,
              offset: Offset(0, 9),
              blurRadius: 23,
            ),
          ],
        ),
        child: Wrap(
          clipBehavior: Clip.antiAlias,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodaysMealItemHeader(
                  title: describeEnum(itemData.alarm.type),
                  subTitle: itemData.subTitle,
                  isCompleted: itemData.isCompleted,
                  isExpanded: isExpanded,
                  isEnabled: itemData.isTimePassed,
                  onCompleteTap: toggleCompletion,
                  onToggleExpansion: toggleExpansion,
                ),
                VerticalSpacing(10),
                ...itemData.mealItems
                    .map((mealItemData) =>
                        TodaysMealSubItem(itemData: mealItemData))
                    .toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
