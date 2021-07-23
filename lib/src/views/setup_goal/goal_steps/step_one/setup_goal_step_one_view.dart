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
    return ViewModelBuilder<SetupGoalStepOneViewModel>.nonReactive(
      builder: (context, model, child) => ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          AppTextField(
            controller: model.heightTextFieldController,
            label: "Height",
          ),
          VerticalSpacing(25),
          AppTextField(
            controller: model.weightTextFieldController,
            label: "Weight",
          ),
          VerticalSpacing(20),
          AppValuesSlider(
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
                Text('2900', style: context.textTheme().headline1),
                Text('Calculated Calories',
                    style: context.textTheme().subtitle1),
              ],
            ),
          ),
        ],
      ),
      viewModelBuilder: () => SetupGoalStepOneViewModel(),
    );
  }

  @override
  String get buttonLabel => "CONTINUE";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Calculate Calories";
}
