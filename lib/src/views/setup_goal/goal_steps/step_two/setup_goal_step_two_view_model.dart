import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/models/video.dart';
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

class SetupGoalStepTwoViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();

  final ScrollController listScrollController = ScrollController();

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

  final TextEditingController macroProteinTextFieldController =
      TextEditingController();
  final TextEditingController macroCarbsTextFieldController =
      TextEditingController();
  final TextEditingController macroFatsTextFieldController =
      TextEditingController();

  void onContinue() => NavService.getStarted();

  init(BuildContext context, Screen screen) {
    super.init(context, screen);
    weightTextFieldController.text =
        "${goal.targetWeight.value > 0 ? goal.targetWeight.value.round() : ''}";
    lowCarbsTextFieldController.text =
        "${describeEnum(PreferredDiet.values.first)}";

    if (goal.macroProtein.value > 0) {
      macroProteinTextFieldController.text = "${goal.macroProtein.value}";
    }
    if (goal.macroCarbs.value > 0) {
      macroCarbsTextFieldController.text = "${goal.macroCarbs.value}";
    }
    if (goal.macroFat.value > 0) {
      macroFatsTextFieldController.text = "${goal.macroFat.value}";
    }
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
    _goalCreationStepsService.registerReactiveValues();
  }

  void onChangeProtein(String value) {
    goal.macroProtein.value = double.parse(value.isEmpty ? "0" : value);
  }

  void onChangeCarbs(String value) {
    goal.macroCarbs.value = double.parse(value.isEmpty ? "0" : value);
  }

  void onChangeFats(String value) {
    goal.macroFat.value = double.parse(value.isEmpty ? "0" : value);
  }

  void onManualEntryCheckChange(bool value) async {
    goal.isManualMacrosEntry.value = value;
    if (value) {
      await Future.delayed(Duration(milliseconds: 100));
      listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 250),
          curve: Curves.ease);
    }
  }
}
