import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter_app/src/shared/app_elevated_button.dart';
import 'package:flutter_starter_app/src/shared/empty_app_bar.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/shared/page_end_spacer.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/shared/goal_step_progress_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'setup_goal_view_model.dart';

class SetupGoalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: EmptyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(20),
                  GoalStepProgressBar(
                      total: model.steps.length + 1,
                      progress: model.currentGoalStepIndex + 1),
                  VerticalSpacing(35),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: ValueKey<String>(model.currentStep.title),
                      children: [
                        Text(model.currentStep.title,
                            style: context.textTheme().headline3),
                        Text(model.currentStep.subTitle,
                            style: context.textTheme().subtitle2)
                      ],
                    ),
                  ),
                  VerticalSpacing(40),
                  // Steps goes here
                  Expanded(
                    child: PageView(
                      controller: model.pageController,
                      children:
                          model.steps.map((goalStep) => goalStep).toList(),
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  // Steps goes here
                  AppElevatedButton.withIcon(
                    child: model.currentStep.buttonLabel,
                    onTap: model.onStepSubmit,
                    icon: Image.asset(Images.icRightArrow),
                  ),
                  PageEndSpacer()
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SetupGoalViewModel(),
    );
  }
}
