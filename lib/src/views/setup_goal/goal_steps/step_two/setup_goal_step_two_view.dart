import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_checkbox.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/app_values_slider.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_two/widgets/manual_macros_block.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'setup_goal_step_two_view_model.dart';

class SetupGoalStepTwoView extends GoalStep {
  FormState? _formState;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepTwoViewModel>.reactive(
      builder: (context, model, child) => Form(
        child: Builder(builder: (context) {
          _formState = Form.of(context);
          return ListView(
            controller: model.listScrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 50),
            children: [
              SizedBox(
                height: 135,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: model.dietOptions
                      .map((dietOption) => Expanded(
                            child: GestureDetector(
                              onTap: () => model.goal.goalTarget.value =
                                  dietOption.goalTarget,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 17),
                                decoration: BoxDecoration(
                                  color: model.goal.goalTarget.value ==
                                          dietOption.goalTarget
                                      ? AppColors.activeLightGreen
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: model.goal.goalTarget.value ==
                                              dietOption.goalTarget
                                          ? AppColors.activeBorderLightGreen
                                          : AppColors.greyBorder),
                                  boxShadow: [
                                    if (model.goal.goalTarget.value ==
                                        dietOption.goalTarget)
                                      BoxShadow(
                                        color: AppColors.activeLightGreen,
                                        offset: Offset(0, 7),
                                        blurRadius: 16,
                                      ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(dietOption.icon,
                                        width: 50,
                                        height: 56,
                                        fit: BoxFit.contain),
                                    VerticalSpacing(10),
                                    Text(dietOption.title,
                                        style: context
                                            .textTheme()
                                            .headline6
                                            ?.copyWith(height: 1.3),
                                        textAlign: TextAlign.center)
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              VerticalSpacing(25),
              AppTextField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                onChange: model.onChangeWeight,
                controller: model.weightTextFieldController,
                label: "Target Weight (lbs)",
              ),
              VerticalSpacing(20),
              AppValuesSlider(
                  onChanged: (value) =>
                      model.goal.targetSleep.value = value.round(),
                  value: model.goal.targetSleep.value.toDouble(),
                  label: "How much sleep",
                  subLabel: "hrs",
                  values: [4, 5, 6, 7, 8, 9]),
              VerticalSpacing(5),
              AppValuesSlider(
                  onChanged: (value) =>
                      model.goal.targetStress.value = value.round(),
                  value: model.goal.targetStress.value.toDouble(),
                  label: "Stress levels",
                  bottomLabel: "No Stress",
                  bottomSubLabel: "Stress",
                  subLabel: "hrs",
                  values: List.generate(10, (index) => index + 1)),
              VerticalSpacing(5),
              AppValuesSlider(
                  onChanged: model.onChangeMeal,
                  value: model.goal.meals.value.toDouble(),
                  label: "Meals",
                  subLabel: "per day",
                  values: Goal.mealSets.keys.map((e) => e.toDouble()).toList()),
              VerticalSpacing(5),
              PopupMenuButton(
                onSelected: model.onPreferredDietSelect,
                itemBuilder: (ctx) => model.preferredEatingDiet
                    .map((preferredDiet) => PopupMenuItem(
                          child: Text(
                              describeEnum(preferredDiet).replaceAll("_", " "),
                              style: context
                                  .textTheme()
                                  .subtitle2
                                  ?.copyWith(fontWeight: FontWeight.w300)),
                          value:
                              model.preferredEatingDiet.indexOf(preferredDiet),
                        ))
                    .toList(),
                child: AppTextField(
                  readOnly: true,
                  readonlyEffect: false,
                  controller: TextEditingController(
                      text: describeEnum(model.goal.preferredDiet.value)
                          .replaceAll("_", " ")),
                  label: "Preferred Eating Diet",
                  defaultValidators: [DefaultValidators.REQUIRED],
                ),
              ),
              VerticalSpacing(25),
              Row(
                children: [
                  AppCheckbox(
                    isChecked: model.goal.isManualMacrosEntry.value,
                    onChange: model.onManualEntryCheckChange,
                  ),
                  HorizontalSpacing(15),
                  Expanded(
                      child: Text("Setup Manual",
                          style: context.textTheme().headline5))
                ],
              ),
              VerticalSpacing(25),
              ManualMacrosBlock(),
              VerticalSpacing(25),
              Container(
                padding: EdgeInsets.all(30),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: AppColors.greyBgLight,
                    offset: Offset(0, 14),
                    blurRadius: 39,
                  ),
                ]),
                child: Column(
                  children: [
                    Text('${model.goal.caloriesIntake.round()}',
                        style: context.textTheme().headline1),
                    Text('Calories Intake',
                        style: context.textTheme().subtitle1),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      viewModelBuilder: () => SetupGoalStepTwoViewModel(),
      onModelReady: (model) => model.init(context, Screen.GOAL_STEP_2),
    );
  }

  @override
  String get buttonLabel => "CONTINUE";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Your Target";

  @override
  bool validate(Goal goal) =>
      (goal.isManualMacrosEntry.value
          ? (goal.macroProtein.value > 0 &&
              goal.macroCarbs.value > 0 &&
              goal.macroFat.value > 0)
          : true) &&
      goal.targetWeight.value > 0;
}
