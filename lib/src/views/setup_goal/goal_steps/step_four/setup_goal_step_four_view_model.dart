import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/remote/api_service.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SetupGoalStepFourViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();
  final ApiService _apiService = locator<ApiService>();

  Macros? _selectedMacro;

  Macros? get selectedMacro =>
      _goalCreationStepsService.goal.isManualMacrosEntry.value
          ? _selectedMacro
          : null;

  bool get isSearchEmpty => foods.isEmpty && searchFieldCtrl.text.isEmpty;

  set selectedMacro(Macros? value) {
    _selectedMacro = value;
    notifyListeners();
  }

  AlarmData? _selectedMeal;

  AlarmData? get selectedMeal => _selectedMeal;

  set selectedMeal(AlarmData? value) {
    _selectedMeal = value;
    notifyListeners();
  }

  double? get selectedMacroValue {
    if (goal.isManualMacrosEntry.value && selectedMacro != null) {
      switch (selectedMacro) {
        case Macros.Protein:
          return goal.macroProtein.value;
        case Macros.Carbs:
          return goal.macroCarbs.value;
        case Macros.Fat:
          return goal.macroFat.value;
      }
    }
    return null;
  }

  TextEditingController searchFieldCtrl = TextEditingController();

  final ScrollController mealsScrollController = ScrollController();

  final expandableController = ExpandableController();

  Goal get goal => _goalCreationStepsService.goal;

  CancelToken? _cancelToken;

  List<Food> _foods = [];

  List<Food> get foods {
    var tempFoods = [...this._foods];
    //tempFoods.sort((v1, v2) => selectedMeal!.foods!.contains(v2) ? 1 : -1);
    return tempFoods;
  }

  List<Food> get foodsList {
    if (!isSearchEmpty) {
      return foods;
    }
    if (selectedMeal != null) {
      return selectedMeal!.foods!.toList();
    }
    return [];
  }

  int get perMealCalorieLimit => (goal.caloriesIntake / meals.length).round();

  int get minRequiredMacroValue {
    if (goal.isManualMacrosEntry.value) {
      switch (selectedMacro) {
        case Macros.Protein:
          return goal.macroProtein.value.round();
        case Macros.Carbs:
          return goal.macroCarbs.value.round();
        case Macros.Fat:
          return goal.macroFat.value.round();
        default:
          return 0;
      }
    } else {
      return perMealCalorieLimit;
    }
  }

  String get selectedMealsMacroValue {
    var finalValue = 0;
    if (goal.isManualMacrosEntry.value) {
      switch (selectedMacro) {
        case Macros.Protein:
          finalValue = selectedMeal!.foods!
              .map((e) => e.protein)
              .reduce((v1, v2) => v1 + v2)
              .round();
          break;
        case Macros.Carbs:
          finalValue = selectedMeal!.foods!
              .map((e) => e.carbs)
              .reduce((v1, v2) => v1 + v2)
              .round();
          break;
        case Macros.Fat:
          finalValue = selectedMeal!.foods!
              .map((e) => e.fat)
              .reduce((v1, v2) => v1 + v2)
              .round();
          break;
        default:
          finalValue = 0;
      }
    } else {
      finalValue = selectedMeal!.foods!
          .map((e) => e.calories)
          .reduce((v1, v2) => v1 + v2)
          .round();
    }
    return (finalValue > minRequiredMacroValue)
        ? "$minRequiredMacroValue+"
        : finalValue.toString();
  }

  List<AlarmData> get meals =>
      goal.alarmData.where((alarm) => alarm.isMeal).toList();

  set foods(List<Food> value) {
    this._foods = value;
    notifyListeners();
  }

  bool _isSearchBoxEmpty = false;

  bool get isSearchBoxEmpty => this._isSearchBoxEmpty;

  set isSearchBoxEmpty(bool value) {
    this._isSearchBoxEmpty = value;
    notifyListeners();
  }

  void onSearchQueryChange() async {
    try {
      var value = searchFieldCtrl.text;
      if (value.isEmpty) {
        return;
      }
      // if (_cancelToken != null) {
      //   _cancelToken?.cancel();
      // }
      _cancelToken = CancelToken();
      isSearchBoxEmpty = value.isEmpty;
      setBusy(true);

      var res = await _apiService.getFoods(value,
          sortBy: selectedMacro,
          //minCalorieLimit: (goal.caloriesIntake / 3) / this.goal.meals.value,
          cancelToken: _cancelToken!);
      if (res != null) {
        foods = res;
      } else {
        foods = [];
      }
    } catch (e) {
      print(e);
      foods = [];
    } finally {
      setBusy(false);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalCreationStepsService];

  void onFoodLikeTap(int idx) {
    if (isSearchEmpty) {
      selectedMeal?.foods!.remove(selectedMeal!.foods![idx]);
      return;
    }

    if (foods[idx].foodId != null) {
      if (selectedMeal!.foods!.contains(foods[idx])) {
        selectedMeal?.foods!.removeAt(selectedMeal!.foods!.indexOf(foods[idx]));
        //fix for reactive list not observing removed values
        _goalCreationStepsService.forceNotify();
      } else {
        selectedMeal?.foods!.add(foods[idx].copyWith(macro: selectedMacro));
      }
      notifyListeners();
    }
  }

  onMealSelect(int index) async {
    selectedMeal = meals[index];
    if (goal.isManualMacrosEntry.value) {
      onMacroTap(0);
    }
  }

  void unselectMeal() {
    selectedMeal = null;
    selectedMacro = null;
    foods = [];
    searchFieldCtrl.clear();
    if (_cancelToken != null) {
      _cancelToken?.cancel();
    }
  }

  onMacroTap(int index) {
    selectedMacro = Macros.values[index];
    this.onSearchQueryChange();
  }

  bool isMealMacrosFullFilled(AlarmData meal) {
    if (meal.foods!.isEmpty) {
      return false;
    }
    if (goal.isManualMacrosEntry.value) {
      var totalProteinsSelected =
          meal.foods!.map((e) => e.protein).reduce((v1, v2) => v1 + v2);
      var totalCarbsSelected =
          meal.foods!.map((e) => e.carbs).reduce((v1, v2) => v1 + v2);
      var totalFatsSelected =
          meal.foods!.map((e) => e.fat).reduce((v1, v2) => v1 + v2);
      return totalProteinsSelected >= goal.macroProtein.value &&
          totalCarbsSelected >= goal.macroCarbs.value &&
          totalFatsSelected >= goal.macroFat.value;
    } else {
      var totalCaloriesSelected =
          meal.foods!.map((e) => e.calories).reduce((v1, v2) => v1 + v2);
      var res = totalCaloriesSelected >= (goal.caloriesIntake / meals.length);
      return res;
    }
  }

  void clearSearch() {
    searchFieldCtrl.clear();
    foods = [];
  }
}
