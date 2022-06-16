import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FoodMealItem extends StatelessWidget {
  final Food food;
  final GestureTapCallback onLikeTap;
  final Macros? forMacro;
  final bool isSelected;

  const FoodMealItem(
      {required this.food,
      this.forMacro,
      required this.onLikeTap,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLikeTap,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1.0, color: AppColors.greyBorder),
              color:
                  isSelected ? AppColors.activeLightGreen : Colors.transparent),
          child: ListTile(
            dense: true,
            title: Text(food.foodName!, style: context.textTheme().subtitle2),
            trailing: Icon(
              Icons.thumb_up,
              color: AppColors.primary,
            ),
            subtitle: Text(
                "${forMacro != null ? describeEnum(forMacro!) : "Calories"}: ${forMacro == null ? food.calories : food.getMacro(forMacro!)}${forMacro == null ? "kcal" : ""}",
                style: context
                    .textTheme()
                    .caption
                    ?.copyWith(color: AppColors.primary)),
          )),
    );
  }
}
