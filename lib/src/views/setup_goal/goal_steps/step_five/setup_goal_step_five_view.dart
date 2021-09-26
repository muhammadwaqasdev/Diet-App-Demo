import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/shared/loading_indicator.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:diet_app/src/base/utils/utils.dart';

import 'setup_goal_step_five_view_model.dart';

class SetupGoalStepFiveView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepFiveViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: Column(
          children:[
            progressItem(context,"Analyzing goal data",model.goalSaveProgressIndex > 0),
            ...model.goal.alarmData.where((alarm) => alarm.isMeal).map((type) =>  progressItem(context,"Setting up your ${describeEnum(type.type)} for a week!",model.goalSaveProgressIndex-1 > model.goal.alarmData.indexOf(type))).toList(),
            progressItem(context,"Finalizing goal setup",model.goalSaveProgressIndex-1 > model.goal.alarmData.where((alarm) => alarm.isMeal).length+1),
          ],
        ),
      ),
      viewModelBuilder: () => SetupGoalStepFiveViewModel(),
    );
  }

  Widget progressItem(BuildContext context, String label,bool isDone) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
    child: Row(children: [
      isDone ? Icon(Icons.check_circle,color: Colors.lightGreen,size: 13) : LoadingIndicator(size: 10,strokeWidth: 2),
      HorizontalSpacing(10),
      Text(label,style: context
          .textTheme()
          .caption
          ?.copyWith(color: AppColors.primary))
    ]),
  );

  @override
  String get buttonLabel => "NEXT";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Setup your day!";

  @override
  bool validate(Goal goal) => true;
}
