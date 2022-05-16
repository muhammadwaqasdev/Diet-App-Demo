import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_progress_indicator.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_four/widgets/food_meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:stacked/stacked.dart';
import 'setup_goal_step_four_view_model.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class SetupGoalStepFourView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepFourViewModel>.reactive(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: AppTextField(
              controller: model.searchFieldCtrl,
              rightSpacing: 45,
              textColor: Colors.black,
              placeholder: "Search your meeal here...",
              defaultValidators: [DefaultValidators.REQUIRED],
              suffixIcon: Positioned(
                right: 0,
                child: InkTouch(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.transparent,
                  onTap: model.onSearchQueryChange,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.search_sharp, color: Colors.white),
                    padding: EdgeInsets.only(
                        top: 15, right: 15, bottom: 15, left: 15),
                  ),
                ),
              ),
            ),
          ),
          VerticalSpacing(5),
          if (model.isBusy)
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppProgressIndicator(
                size: 30,
                brightness: Brightness.dark,
              ),
            )),
          if (model.foods.isEmpty && !model.isSearchBoxEmpty && !model.isBusy)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No meals found!",
                  textAlign: TextAlign.center,
                  style: context.textTheme().subtitle2,
                ),
              ),
            ),
          if (!model.isBusy)
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.only(bottom: 50),
              itemCount: model.foods.length,
              itemBuilder: (ctx, idx) => FoodMealItem(
                  food: model.foods[idx],
                  onDislikeTap: () => model.onDislikeTap(idx)),
            ))
        ],
      ),
      viewModelBuilder: () => SetupGoalStepFourViewModel(),
      onModelReady: (model) => model.init(context, Screen.GOAL_STEP_4),
    );
  }

  @override
  String get buttonLabel => "SAVE";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Almost There";

  @override
  bool validate(Goal goal) => true;
}
