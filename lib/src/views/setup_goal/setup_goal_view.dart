import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/goal_step_progress_bar.dart';
import 'package:diet_app/src/shared/page_end_spacer.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'setup_goal_view_model.dart';

class SetupGoalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupGoalViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: EmptyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: model.currentStep.overridePageHorizontalPadding
                    ? 0
                    : model.currentStep.pageHorizontalPadding),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            model.currentStep.overridePageHorizontalPadding
                                ? model.currentStep.pageHorizontalPadding
                                : 0),
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
                      ],
                    ),
                  ),
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
                  if (!model.isKeyboardVisible) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              model.currentStep.overridePageHorizontalPadding
                                  ? model.currentStep.pageHorizontalPadding
                                  : 0),
                      child: Row(
                        children: [
                          if (model.currentGoalStepIndex > 0 &&
                              !model.isBusy) ...[
                            Expanded(
                              child: AppElevatedButton.flat(
                                  child: "BACK", onTap: model.onStepBack),
                            ),
                            HorizontalSpacing(10)
                          ],
                          Expanded(
                            child: AppElevatedButton.withIcon(
                              isLoading: model.isBusy,
                              isEnabled: model.currentStep.validate(model.goal),
                              child: model.currentStep.buttonLabel,
                              onTap: () => model.onStepSubmit(context),
                              icon: Image.asset(Images.icRightArrow),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PageEndSpacer()
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SetupGoalViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}
