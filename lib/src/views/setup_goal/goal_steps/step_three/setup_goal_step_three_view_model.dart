import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:stacked/stacked.dart';

class SetupGoalStepThreeViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final GoalCreationStepsService _goalCreationStepsService =
      locator<GoalCreationStepsService>();

  Goal get goal => _goalCreationStepsService.goal;

  init(BuildContext context, Screen screen) {
    super.init(context, screen);
    setupSlots();
  }

  void openTimePicker(BuildContext context, AlarmData alarmData) async {
    TimeOfDay? pickedTime = (await showRoundedTimePicker(
        context: context,
        theme: AppTheme.get(),
        initialTime: alarmData.time,
        borderRadius: 16));
    if (pickedTime == null) {
      return;
    }
    alarmData.time = pickedTime;
    notifyListeners();
    context.closeKeyboardIfOpen();
    setupSlots();
  }

  void setupSlots() {
    int dinnerIndex =
        goal.alarmData.indexWhere((alarm) => alarm.type == AlarmType.Dinner);
    goal.alarmData[dinnerIndex].time = TimeOfDay(
        hour: goal.sleepAlarm.time.hour - 1,
        minute: goal.sleepAlarm.time.minute);
    if (goal.meals.value > 2) {
      List<TimeOfDay> slots = buildTimeSlots(goal.meals.value.toDouble() - 2,
          goal.breakfastAlarm.time, goal.dinnerAlarm.time);
      print(slots);
      switch (goal.meals.value) {
        case 5:
          goal.alarmData[2].time = slots[0];
          goal.alarmData[3].time = slots[1];
          goal.alarmData[4].time = slots[2];
          break;
        case 4:
          goal.alarmData[2].time = slots[0];
          goal.alarmData[3].time = slots[1];
          break;
        case 3:
          goal.alarmData[2].time = slots[0];
          break;
      }
    } else {
      String totalStrValue =
          "${calculateTimeValue(goal.breakfastAlarm.time, goal.dinnerAlarm.time) / 2}";
      int hourVal = int.parse(totalStrValue.split(".").first);
      int minuteVal = int.parse(totalStrValue.split(".").last);
      goal.alarmData.insert(
          2,
          AlarmData(
              type: AlarmType.Lunch,
              time: TimeOfDay(hour: hourVal, minute: minuteVal)));
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_goalCreationStepsService];
}
