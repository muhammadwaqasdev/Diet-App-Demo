import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/services/local/navigation_service.dart';
import 'package:flutter_starter_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:flutter_starter_app/src/views/setup_goal/goal_steps/step_two/setup_goal_step_two_view.dart';
import 'package:stacked/stacked.dart';

import 'goal_steps/step_one/setup_goal_step_one_view.dart';
import 'goal_steps/step_three/setup_goal_step_three_view.dart';

class SetupGoalViewModel extends BaseViewModel {
  PageController pageController = PageController(initialPage: 0);

  List<GoalStep> get steps => [
        SetupGoalStepOneView(),
        SetupGoalStepTwoView(),
        SetupGoalStepThreeView()
      ];
  GoalStep get currentStep => steps[currentGoalStepIndex];

  int _currentGoalStepIndex = 0;
  int get currentGoalStepIndex => this._currentGoalStepIndex;
  set currentGoalStepIndex(int value) {
    this._currentGoalStepIndex = value;
    notifyListeners();
  }

  void onStepSubmit() {
    if (currentGoalStepIndex + 2 <= steps.length) {
      currentGoalStepIndex = currentGoalStepIndex + 1;
      pageController.animateToPage(
        currentGoalStepIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    } else {
      NavService.dashboard();
    }
  }
}
