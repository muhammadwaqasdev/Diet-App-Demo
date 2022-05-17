import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:stacked/stacked.dart';

class SetupGoalStepFiveViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();

  Goal get goal => _goalCreationStepsService.goal;

  int get goalSaveProgressIndex => _goalCreationStepsService.loadingStep;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalCreationStepsService];
}
