import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class _DietGoalOption {
  final GoalTarget goalTarget;

  String get title => describeEnum(goalTarget).replaceAll("_", " ");
  final String icon;

  _DietGoalOption({required this.goalTarget, required this.icon});

  bool operator ==(o) =>
      o is _DietGoalOption && title == o.title && icon == o.icon;

  int get hashCode => int.parse(title.characters.last);
}

class SetupGoalStepTwoViewModel extends ReactiveViewModel {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();

  Goal get goal => _goalCreationStepsService.goal;

  List<_DietGoalOption> get dietOptions => [
        _DietGoalOption(
            goalTarget: GoalTarget.Weight_Loss, icon: Images.icWeightLoss),
        _DietGoalOption(
            goalTarget: GoalTarget.Gain_Weight, icon: Images.icWeightGain),
        _DietGoalOption(
            goalTarget: GoalTarget.Maintain, icon: Images.icWeightMaintain),
      ];

  List<PreferredDiet> get preferredEatingDiet => PreferredDiet.values;

  final TextEditingController heightTextFieldController =
      TextEditingController();
  final TextEditingController weightTextFieldController =
      TextEditingController();
  final TextEditingController lowCarbsTextFieldController =
      TextEditingController(text: describeEnum(PreferredDiet.values.first));

  void onContinue() => NavService.getStarted();

  init() {
    weightTextFieldController.text =
        "${goal.targetWeight.value > 0 ? goal.targetWeight.value.round() : ''}";
    lowCarbsTextFieldController.text =
        "${describeEnum(PreferredDiet.values.first)}";
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalCreationStepsService];

  void onChangeWeight(String value) {
    goal.targetWeight.value = value.isNotEmpty ? double.parse(value) : 0;
    if (goal.targetWeight.value == goal.weight.value) {
      goal.goalTarget.value = GoalTarget.Maintain;
    } else if (goal.targetWeight.value > goal.weight.value) {
      goal.goalTarget.value = GoalTarget.Gain_Weight;
    } else if (goal.targetWeight.value < goal.weight.value) {
      goal.goalTarget.value = GoalTarget.Weight_Loss;
    }
  }

  void onPreferredDietSelect(int value) {
    goal.preferredDiet.value = preferredEatingDiet[value];
  }

  onChangeMeal(double mealCount) {
    goal.meals.value = mealCount.round();
    goal.alarmData.clear();
    goal.alarmData.addAll(Goal.mealSets[goal.meals.value] ?? []);
  }
}
