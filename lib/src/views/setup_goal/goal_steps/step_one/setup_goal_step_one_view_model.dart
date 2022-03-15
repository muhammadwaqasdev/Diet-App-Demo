import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SetupGoalStepOneViewModel extends ReactiveViewModel {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();

  final TextEditingController heightFtTextCtrl = TextEditingController();
  final TextEditingController heightInTextCtrl = TextEditingController();
  final TextEditingController weightTextCtrl = TextEditingController();

  Goal get goal => _goalCreationStepsService.goal;

  void onContinue() => NavService.getStarted();

  init() {
    heightFtTextCtrl.text =
        goal.heightFt.value > 0 ? "${goal.heightFt.value}" : "";
    heightInTextCtrl.text =
        goal.heightIn.value > 0 ? "${goal.heightIn.value}" : "";
    /*"${goal.heightFt.value > 0 ? "${goal.heightFt.value}.${goal.heightIn.value}" : ''}";*/
    weightTextCtrl.text = "${goal.weight.value > 0 ? goal.weight.value : ''}";
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalCreationStepsService];
}
