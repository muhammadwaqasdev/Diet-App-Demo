import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class FoodMealItem extends StatelessWidget {
  final Food food;
  final GestureTapCallback onDislikeTap;

  const FoodMealItem({required this.food, required this.onDislikeTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1.0, color: AppColors.greyBorder),
        ),
        child: ListTile(
          dense: true,
          title: Text(food.foodName!, style: context.textTheme().subtitle2),
          trailing: GestureDetector(
            onTap: onDislikeTap,
            child: Icon(
              Icons.thumb_down,
              color: Colors.red,
            ),
          ),
          subtitle: Text("Calories: ${food.calories}kcal",
              style: context
                  .textTheme()
                  .caption
                  ?.copyWith(color: AppColors.primary)),
        ));
  }
}
