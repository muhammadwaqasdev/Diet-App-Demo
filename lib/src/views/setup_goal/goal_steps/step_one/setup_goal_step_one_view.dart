import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/app_values_slider.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:stacked/stacked.dart';
import 'setup_goal_step_one_view_model.dart';

class SetupGoalStepOneView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepOneViewModel>.reactive(
      builder: (context, model, child) => ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          AppTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            onChange: (value) => heightValueOnChange(
                model.goal.heightFt, model.goal.heightIn, value),
            controller: model.heightTextCtrl,
            label: "Height (ft)",
          ),
          VerticalSpacing(25),
          AppTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            onChange: (value) => model.goal.weight.value =
                value.isNotEmpty ? double.parse(value) : 0,
            controller: model.weightTextCtrl,
            label: "Weight (lbs)",
          ),
          VerticalSpacing(20),
          AppValuesSlider(
              onChanged: (value) => model.goal.activityLevel.value = value,
              value: model.goal.activityLevel.value,
              label: "Activity Level",
              values: [0.8, 1, 1.2, 1.35, 1.5],
              shouldRound: false),
          VerticalSpacing(45),
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
                Text(
                    (model.goal.heightFt.value > 0 &&
                            model.goal.weight.value > 0)
                        ? '${model.goal.calculatedCalories.round()}'
                        : "0",
                    style: context.textTheme().headline1),
                Text('Basal Metabolic Rate (BMR)',
                    style: context.textTheme().subtitle1,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
      viewModelBuilder: () => SetupGoalStepOneViewModel(),
      onModelReady: (model) => model.init(),
    );
  }

  @override
  String get buttonLabel => "CONTINUE";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Calculate Calories";

  @override
  bool validate(Goal goal) => goal.heightFt.value > 0 && goal.weight.value > 0;
}
