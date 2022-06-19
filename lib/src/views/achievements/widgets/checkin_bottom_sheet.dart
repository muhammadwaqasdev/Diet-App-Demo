import 'dart:io';

import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/setup_goal/goal_steps/step_five/setup_goal_step_five_view.dart';
import 'package:flutter/material.dart';

class CheckinBottomSheet extends StatelessWidget {
  final bool isForProgress;
  final TextEditingController _weightValue = TextEditingController();

  CheckinBottomSheet({Key? key, this.isForProgress = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 20, right: 20, bottom: Platform.isIOS ? 30 : 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.51),
                    offset: Offset(0, 0),
                    blurRadius: 39,
                  ),
                ],
                color: AppColors.semiWhite,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child:
                isForProgress ? _progressView(context) : _weightForm(context),
          ),
        ],
      ),
    );
  }

  Widget _weightForm(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New check in", style: context.textTheme().headline4),
          Text("Enter your current weight to schedule your next week!",
              style: context.textTheme().headline6),
          VerticalSpacing(10),
          AppTextField(
            controller: _weightValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid weight!";
              }
              return null;
            },
            placeholder: "Enter your current weight",
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
          ),
          VerticalSpacing(20),
          AppElevatedButton(
              child: "Update",
              onTap: () async {
                if (Form.of(context)?.validate() == true) {
                  Navigator.pop(context, true);
                  var goal = locator<GoalCreationStepsService>().goal;
                  var oldWeight = goal.weight;
                  var newWeight = _weightValue.text.isNotEmpty
                      ? double.parse(_weightValue.text)
                      : 0;
                  switch (goal.goalTarget.value) {
                    case GoalTarget.Weight_Loss:
                      if (newWeight >= oldWeight.value) {
                        goal.additionalIntakePercentage.value = -5;
                      }
                      break;
                    case GoalTarget.Gain_Weight:
                      if (newWeight <= oldWeight.value) {
                        goal.additionalIntakePercentage.value = 5;
                      }
                      break;
                    case GoalTarget.Maintain:
                      if (newWeight > oldWeight.value) {
                        goal.additionalIntakePercentage.value = -5;
                      } else if (newWeight < oldWeight.value) {
                        goal.additionalIntakePercentage.value = 5;
                      }
                      break;
                  }
                  int? existingValue = await getDataFromPref(
                      PrefKeys.CHECK_IN_COUNT, PrefDataType.INT);
                  var currentCount = 1;
                  if (existingValue != null) {
                    currentCount += existingValue;
                  }
                  await saveDataInPref(
                      PrefKeys.CHECK_IN_COUNT, currentCount, PrefDataType.INT);
                }
              })
        ],
      );

  Widget _progressView(BuildContext context) => Column(
        children: [
          Text("Please wait...", style: context.textTheme().headline4),
          Text("Hold on a little, we're setting up your goal!",
              style: context.textTheme().headline6),
          VerticalSpacing(10),
          SetupGoalStepFiveView(isForCheckIn: true),
        ],
      );
}
