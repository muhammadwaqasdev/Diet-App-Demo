import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter_app/src/shared/app_textfield.dart';
import 'package:flutter_starter_app/src/shared/app_values_slider.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/shared/ink_touch.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/views/setup_goal/goal_steps/base/goal_step.dart';
import 'package:stacked/stacked.dart';
import 'setup_goal_step_two_view_model.dart';

class SetupGoalStepTwoView extends GoalStep {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalStepTwoViewModel>.reactive(
      builder: (context, model, child) => ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 50),
        children: [
          SizedBox(
            height: 135,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: model.dietOptions
                  .map((dietOption) => Expanded(
                        child: GestureDetector(
                          onTap: () => model.onDietGoalTap(dietOption),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 17),
                            decoration: BoxDecoration(
                              color: model.selectedDietOption == dietOption
                                  ? AppColors.activeLightGreen
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  width: 1.0,
                                  color: model.selectedDietOption == dietOption
                                      ? AppColors.activeBorderLightGreen
                                      : AppColors.greyBorder),
                              boxShadow: [
                                if (dietOption == model.selectedDietOption)
                                  BoxShadow(
                                    color: const Color(0xffeafab0),
                                    offset: Offset(0, 7),
                                    blurRadius: 16,
                                  ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(dietOption.icon,
                                    width: 50, height: 56, fit: BoxFit.contain),
                                VerticalSpacing(10),
                                Text(dietOption.title,
                                    style: context
                                        .textTheme()
                                        .headline6
                                        ?.copyWith(height: 1.3),
                                    textAlign: TextAlign.center)
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          VerticalSpacing(25),
          AppTextField(
            controller: model.heightTextFieldController,
            label: "Height",
          ),
          VerticalSpacing(25),
          AppTextField(
            controller: model.weightTextFieldController,
            label: "Weight",
          ),
          VerticalSpacing(20),
          AppValuesSlider(
              label: "How much sleep",
              subLabel: "hrs",
              values: [4, 5, 6, 7, 8, 9]),
          VerticalSpacing(5),
          AppValuesSlider(
              label: "Stress level",
              subLabel: "hrs",
              values: List.generate(10, (index) => index + 1)),
          VerticalSpacing(5),
          AppTextField(
            controller: model.lowCarbsTextFieldController,
            label: "low carbs",
          ),
          VerticalSpacing(25),
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: AppColors.greyBgLight,
                offset: Offset(0, 14),
                blurRadius: 39,
              ),
            ]),
            child: Column(
              children: [
                Text('4900', style: context.textTheme().headline1),
                Text('Calories Intake', style: context.textTheme().subtitle1),
              ],
            ),
          ),
        ],
      ),
      viewModelBuilder: () => SetupGoalStepTwoViewModel(),
    );
  }

  @override
  String get buttonLabel => "CONTINUE";

  @override
  String get subTitle => "Lorem ipsum dolor sit amet, consetetur";

  @override
  String get title => "Your Target";
}
