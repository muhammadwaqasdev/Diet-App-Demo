import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/app_values_slider.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_three/widgets/alarm_item.dart';
import 'package:stacked/stacked.dart';
import 'setup_goal_step_three_view_model.dart';

class SetupGoalStepThreeView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepThreeViewModel>.nonReactive(
      builder: (context, model, child) => ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          AlarmItem(
            time: DateTime.parse("2021-07-07 09:00:00"),
            label: "Wakeup Alarm",
          ),
          VerticalSpacing(20),
          AlarmItem(
            time: DateTime.parse("2021-07-07 12:00:00"),
            label: "Sleep Alarm",
          )
        ],
      ),
      viewModelBuilder: () => SetupGoalStepThreeViewModel(),
    );
  }

  @override
  String get buttonLabel => "SAVE YOUR GOAL";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Almost There";
}
