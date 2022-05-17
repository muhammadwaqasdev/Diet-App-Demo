import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../setup_goal_step_two_view_model.dart';

class ManualMacrosBlock extends ViewModelWidget<SetupGoalStepTwoViewModel> {
  final expandableController = ExpandableController();

  @override
  Widget build(BuildContext context, SetupGoalStepTwoViewModel model) =>
      ExpandablePanel(
        controller: expandableController
          ..expanded = model.goal.isManualMacrosEntry.value,
        collapsed: SizedBox.shrink(),
        expanded: Column(
          children: [
            AppTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onChange: model.onChangeProtein,
              controller: model.macroProteinTextFieldController,
              label: "Protein",
              defaultValidators: [
                if (expandableController.expanded) DefaultValidators.REQUIRED
              ],
            ),
            VerticalSpacing(20),
            AppTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onChange: model.onChangeCarbs,
              controller: model.macroCarbsTextFieldController,
              label: "Carbs",
              defaultValidators: [
                if (expandableController.expanded) DefaultValidators.REQUIRED
              ],
            ),
            VerticalSpacing(20),
            AppTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onChange: model.onChangeFats,
              controller: model.macroFatsTextFieldController,
              label: "Fats",
              defaultValidators: [
                if (expandableController.expanded) DefaultValidators.REQUIRED
              ],
            ),
          ],
        ),
      );
}
