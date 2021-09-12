import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/keyboard_service.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/widgets/completion_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_two/setup_goal_step_two_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'goal_steps/step_four/setup_goal_step_four_view.dart';
import 'goal_steps/step_one/setup_goal_step_one_view.dart';
import 'goal_steps/step_three/setup_goal_step_three_view.dart';

class SetupGoalViewModel extends ReactiveViewModel {
  final KeyboardService _keyboardService = locator<KeyboardService>();
  final BottomSheetService _sheetService = locator<BottomSheetService>();
  final GoalCreationStepsService _goalService =
      locator<GoalCreationStepsService>();

  Goal get goal => _goalService.goal;

  bool get isKeyboardVisible => _keyboardService.isKeyboardVisible;

  PageController pageController = PageController(initialPage: 0);

  List<GoalStep> get steps => [
        SetupGoalStepOneView(),
        SetupGoalStepTwoView(),
        SetupGoalStepThreeView(),
        SetupGoalStepFourView(),
      ];
  GoalStep get currentStep => steps[currentGoalStepIndex];

  int _currentGoalStepIndex = 0;
  int get currentGoalStepIndex => this._currentGoalStepIndex;
  set currentGoalStepIndex(int value) {
    this._currentGoalStepIndex = value;
    notifyListeners();
  }

  void onStepBack() {
    currentGoalStepIndex = currentGoalStepIndex - 1;
    pageController.animateToPage(
      currentGoalStepIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void onStepSubmit(BuildContext context) async {
    if (currentGoalStepIndex + 2 <= steps.length) {
      currentGoalStepIndex = currentGoalStepIndex + 1;
      pageController.animateToPage(
        currentGoalStepIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    } else {
      //NavService.dashboard();
      await _goalService.save();
      showModalBottomSheet(
          context: context, builder: (_) => CompletionBottomSheet());
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_keyboardService, _goalService];
}
