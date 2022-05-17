import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/remote/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SetupGoalStepFourViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();
  final ApiService _apiService = locator<ApiService>();

  TextEditingController searchFieldCtrl = TextEditingController();

  Goal get goal => _goalCreationStepsService.goal;

  CancelToken? _cancelToken;

  List<Food> _foods = [];

  List<Food> get foods => this
      ._foods
      .where((element) => !goal.dislikedMeals.contains(element.foodId))
      .toList();

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
      if (_cancelToken != null) {
        //_cancelToken?.cancel();
      }
      var value = searchFieldCtrl.text;
      _cancelToken = CancelToken();
      isSearchBoxEmpty = value.isEmpty;
      setBusy(true);

      var res = await _apiService.getFoods(value,
          minCalorieLimit: goal.caloriesIntake / this.goal.meals.value,
          dislikedMeals:
              goal.dislikedMeals.map((mealId) => int.parse(mealId)).toList(),
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

  void onDislikeTap(int idx) {
    if (foods[idx].foodId != null) {
      goal.dislikedMeals.add(foods[idx].foodId!);
      notifyListeners();
    }
  }
}
