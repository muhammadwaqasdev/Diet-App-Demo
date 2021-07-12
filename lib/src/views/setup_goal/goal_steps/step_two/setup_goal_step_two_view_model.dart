import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';

class _DietGoalOption {
  final String title;
  final String icon;

  _DietGoalOption({required this.title, required this.icon});

  bool operator ==(o) =>
      o is _DietGoalOption && title == o.title && icon == o.icon;
  int get hashCode => int.parse(title.characters.last);
}

class SetupGoalStepTwoViewModel extends BaseViewModel {
  List<_DietGoalOption> get dietOptions => [
        _DietGoalOption(title: "Weight Loss", icon: Images.icWeightLoss),
        _DietGoalOption(title: "Gain Weight", icon: Images.icWeightGain),
        _DietGoalOption(title: "Maintain", icon: Images.icWeightMaintain),
      ];

  int _selectedDietGoalIndex = 0;
  int get selectedDietGoalIndex => this._selectedDietGoalIndex;
  set selectedDietGoalIndex(int value) {
    this._selectedDietGoalIndex = value;
    notifyListeners();
  }

  _DietGoalOption get selectedDietOption => dietOptions[selectedDietGoalIndex];

  final TextEditingController heightTextFieldController =
      TextEditingController(text: "5.11");
  final TextEditingController weightTextFieldController =
      TextEditingController(text: "80");
  final TextEditingController lowCarbsTextFieldController =
      TextEditingController(text: "low carbs");

  void onContinue() => NavService.getStarted();

  void onDietGoalTap(_DietGoalOption option) {
    selectedDietGoalIndex = dietOptions.indexOf(option);
  }
}
