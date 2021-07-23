import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/shared/completed_check.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_item_header.dart';
import 'package:diet_app/src/views/dashboard/widgets/todays_meals/todays_meal_sub_item.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class TodaysMealItemModel {
  final String title;
  final String subTitle;
  final bool isCompleted;
  final bool isExpanded;
  final List<TodaysMealSubItemModel> mealItems;

  const TodaysMealItemModel(
      {required this.title,
      required this.subTitle,
      this.isCompleted = false,
      this.isExpanded = false,
      this.mealItems = const []});
}

class TodaysMealItem extends StatefulWidget {
  final TodaysMealItemModel itemData;

  const TodaysMealItem({required this.itemData});

  @override
  _TodaysMealItemState createState() => _TodaysMealItemState(this.itemData);
}

class _TodaysMealItemState extends State<TodaysMealItem>
    with TickerProviderStateMixin {
  final TodaysMealItemModel itemData;
  bool isExpanded = false;
  bool isCompleted = false;

  _TodaysMealItemState(this.itemData);

  @override
  void initState() {
    isExpanded = itemData.isExpanded;
    isCompleted = itemData.isCompleted;
    super.initState();
  }

  void toggleExpansion() async {
    if (isCompleted) {
      return;
    }
    setState(() {
      isExpanded = !isExpanded;
      if (!isExpanded) {
        isCompleted = false;
      }
    });
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {});
  }

  void toggleCompletion() async {
    setState(() {
      isCompleted = !isCompleted;
      if (isCompleted) {
        isExpanded = false;
      }
    });
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleExpansion,
      child: AnimatedSize(
        vsync: this,
        duration: Duration(milliseconds: 250),
        child: AnimatedContainer(
          height: isExpanded ? null : 85,
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 24),
          decoration: BoxDecoration(
            color: isExpanded ? Colors.white : Colors.transparent,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.greyDarkBgBorderColor, width: 1)),
            boxShadow: [
              BoxShadow(
                color: isExpanded ? Color(0x14000000) : Colors.transparent,
                offset: Offset(0, 9),
                blurRadius: 23,
              ),
            ],
          ),
          child: Wrap(
            clipBehavior: Clip.hardEdge,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodaysMealItemHeader(
                    title: itemData.title,
                    subTitle: itemData.subTitle,
                    isCompleted: isCompleted,
                    isExpanded: isExpanded,
                    onCompleteTap: toggleCompletion,
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
      ),
    );
  }
}
