import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/views/achievements/widgets/checkin_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AchievementsViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();

  final LocalDatabaseService _localDatabaseService =
      locator<LocalDatabaseService>();

  List<DailyIntake> intakes = [];

  DailyIntake get firstIntake => intakes.first;

  DailyIntake get lastIntake => intakes.last;

  DateTime get lastIntakeDateTime => lastIntake.date
      .setTime(lastIntake.alams[lastIntake.alams.length - 2].time);

  int get totlalConsumedCalories => intakes
      .map((intake) => intake.consumedCalories)
      .reduce((v1, v2) => v1 + v2);

  int get totlalProteins =>
      intakes.map((intake) => intake.totalProtein).reduce((v1, v2) => v1 + v2);

  int get totlalCarbs =>
      intakes.map((intake) => intake.totalCarbs).reduce((v1, v2) => v1 + v2);

  int get totlalFats =>
      intakes.map((intake) => intake.totalFats).reduce((v1, v2) => v1 + v2);

  int get totlalConsumedProteins => intakes
      .map((intake) => intake.consumedProtein)
      .reduce((v1, v2) => v1 + v2);

  int get totlalConsumedCarbs =>
      intakes.map((intake) => intake.consumedCarbs).reduce((v1, v2) => v1 + v2);

  int get totlalConsumedFats =>
      intakes.map((intake) => intake.consumedFats).reduce((v1, v2) => v1 + v2);

  int get nextCheckinDaysLeft =>
      lastIntakeDateTime.difference(DateTime.now()).inDays;

  int get nextCheckinHoursLeft =>
      lastIntakeDateTime.difference(DateTime.now()).inSeconds;

  DateTime? goalStartDate;
  int totalCheckins = 0;

  init(BuildContext context, Screen screen) async {
    super.init(context, screen);
    setBusy(true);
    var goalStartTS =
        await getDataFromPref(PrefKeys.GOAL_CREATION_DATE, PrefDataType.INT);
    goalStartDate = DateTime.fromMillisecondsSinceEpoch(goalStartTS);
    int? checkinsCount =
        await getDataFromPref(PrefKeys.CHECK_IN_COUNT, PrefDataType.INT);
    if (checkinsCount != null) {
      totalCheckins = checkinsCount;
    }
    intakes = await _localDatabaseService.intakeDao.getAllIntakes();
    notifyListeners();
    setBusy(false);
  }

  static Future<bool?> showWeightSheet(BuildContext context,
          {bool isForProgress = false}) async =>
      showModalBottomSheet<bool>(
          isDismissible: !isForProgress,
          enableDrag: !isForProgress,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (childContext) =>
              Form(child: CheckinBottomSheet(isForProgress: isForProgress)));

  onCheckInTap(BuildContext context) async {
    bool? isDone = await showWeightSheet(context);
    if (isDone != null && isDone) {
      showWeightSheet(context, isForProgress: true);
      await _goalCreationStepsService.save();
      _goalCreationStepsService.loadingStep = 0;
      NavService.dashboard();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalCreationStepsService];
}
