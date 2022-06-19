import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:stacked/stacked.dart';

class GroceryListViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalService =
      locator<GoalCreationStepsService>();

  Iterable<Food> get _allFoods => _goalService.goal.alarmData
      .where((p0) => p0.isMeal)
      .map((alarm) => alarm.foods?.toList() ?? [])
      .expand((element) => element);

  List<Food> get foods => Set<Food>.from(_allFoods).toList();

  Map<String, int> get weights {
    Map<String, int> items = {};
    for (var food in foods) {
      items[food.foodId!] = foods.where((f) => f == food).length;
    }
    return items;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_goalService];
}
