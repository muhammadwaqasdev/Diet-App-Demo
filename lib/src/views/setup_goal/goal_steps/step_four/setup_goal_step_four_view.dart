import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_progress_indicator.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_four/widgets/chip_list.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_four/widgets/food_meal_item.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

import 'setup_goal_step_four_view_model.dart';

class SetupGoalStepFourView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepFourViewModel>.reactive(
      builder: (context, model, child) => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.goal.isManualMacrosEntry.value)
                ExpandablePanel(
                  controller: model.expandableController
                    ..expanded = model.selectedMeal?.type == null,
                  collapsed: ChipList(
                    onHeaderTap: model.unselectMeal,
                    header: Chip(
                        padding: EdgeInsets.only(
                            top: 7, bottom: 7, left: 5, right: 18),
                        label: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.close, color: Colors.white, size: 20),
                            HorizontalSpacing(10),
                            Text(
                              describeEnum(model.selectedMeal?.type ??
                                  AlarmType.values.first),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: AppColors.primary),
                    selectedIndex: Macros.values
                        .indexOf(model.selectedMacro ?? Macros.Carbs),
                    horizontalPadding: pageHorizontalPadding,
                    itemsCount: Macros.values.length,
                    labelBuilder: (index) => describeEnum(Macros.values[index]),
                    onTapChip: (index) => model.onMacroTap(index),
                  ),
                  expanded: ChipList(
                    selectedIndex: model.selectedMeal == null
                        ? null
                        : model.meals.indexOf(model.selectedMeal!),
                    horizontalPadding: pageHorizontalPadding,
                    itemsCount: model.meals.length,
                    labelBuilder: (index) =>
                        describeEnum(model.meals[index].type),
                    onTapChip: (index) => model.onMealSelect(index),
                  ),
                ),
              if (!model.goal.isManualMacrosEntry.value)
                ChipList(
                  selectedIndex: model.selectedMeal != null
                      ? model.meals.indexOf(model.selectedMeal!)
                      : null,
                  horizontalPadding: pageHorizontalPadding,
                  itemsCount: model.meals.length,
                  labelBuilder: (index) =>
                      describeEnum(model.meals[index].type),
                  onTapChip: (index) => model.onMealSelect(index),
                ),
              VerticalSpacing(35),
              AnimatedCrossFade(
                duration: Duration(milliseconds: 250),
                crossFadeState: model.selectedMeal != null
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: SizedBox.shrink(),
                secondChild: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
                  child: AppTextField(
                    controller: model.searchFieldCtrl,
                    rightSpacing: 45,
                    textColor: Colors.black,
                    placeholder: "Search your meal here...",
                    defaultValidators: [DefaultValidators.REQUIRED],
                    suffixIcon: Positioned(
                      top: 0,
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
              if (model.foods.isEmpty &&
                  !model.isSearchBoxEmpty &&
                  !model.isBusy &&
                  !model.isSearchEmpty)
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
              if (!model.isBusy && model.selectedMeal != null)
                Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 50),
                  itemCount: model.isSearchEmpty
                      ? (model.selectedMeal?.foods?.length ?? 0)
                      : model.foods.length,
                  itemBuilder: (ctx, idx) => FoodMealItem(
                      food: model.foodsList[idx],
                      forMacro: model.selectedMacro,
                      isSelected: model.selectedMeal!.foods!
                          .contains(model.foodsList[idx]),
                      onLikeTap: () => model.onFoodLikeTap(idx)),
                ))
            ],
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              bottom: (model.selectedMeal != null &&
                      model.selectedMeal!.foods!.isNotEmpty)
                  ? 20
                  : -100,
              right: 20,
              child: Transform.scale(
                scale: 1.5,
                child: FloatingActionButton(
                    onPressed: () {},
                    child: AnimatedDefaultTextStyle(
                        child: (model.selectedMeal != null &&
                                model.selectedMeal!.foods!.isNotEmpty)
                            ? Text(
                                "${model.selectedMealsMacroValue}/${model.minRequiredMacroValue}",
                                textAlign: TextAlign.center)
                            : SizedBox.shrink(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        duration: Duration(milliseconds: 250)),
                    backgroundColor: AppColors.primary),
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
  String get title => "Select Meals";

  @override
  bool get overridePageHorizontalPadding => true;

  @override
  bool validate(Goal goal) =>
      goal.alarmData.where((p0) => p0.isFullFilled(goal)).length >=
      goal.alarmData.where((p0) => p0.isMeal).length;
}
