import 'dart:io';

import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class EditGoalBottomSheet extends StatelessWidget {
  final bool isForProgress;

  EditGoalBottomSheet({Key? key, this.isForProgress = false}) : super(key: key);

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
            child: _weightForm(context),
          ),
        ],
      ),
    );
  }

  Widget _weightForm(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Next week goal", style: context.textTheme().headline4),
          Text(
              "Do you want to continue with your current goal or continue with the current one?",
              style: context.textTheme().headline6),
          VerticalSpacing(20),
          Row(
            children: [
              Expanded(
                  child: AppElevatedButton(
                child: "Update",
                onTap: () => Navigator.pop(context, false),
                isFlat: true,
              )),
              HorizontalSpacing(20),
              Expanded(
                  child: AppElevatedButton(
                      child: "Continue",
                      onTap: () => Navigator.pop(context, true))),
            ],
          )
        ],
      );
}
