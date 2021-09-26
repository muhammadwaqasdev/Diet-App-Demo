import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_three/widgets/alarm_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'setup_goal_step_three_view_model.dart';

class SetupGoalStepThreeView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepThreeViewModel>.reactive(
      builder: (context, model, child) => ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          //model.goal.alarmData
          ...[
            model.goal.wakeUpAlarm,
            model.goal.breakfastAlarm,
            model.goal.sleepAlarm
          ]
              .map((alarm) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AlarmItem(
                      alarmData: alarm,
                      onTap: () => model.openTimePicker(context, alarm),
                    ),
                  ))
              .toList(),
        ],
      ),
      viewModelBuilder: () => SetupGoalStepThreeViewModel(),
      onModelReady: (model) => model.init(),
    );
  }

  @override
  String get buttonLabel => "NEXT";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Setup your day!";

  @override
  bool validate(Goal goal) => true;
}
