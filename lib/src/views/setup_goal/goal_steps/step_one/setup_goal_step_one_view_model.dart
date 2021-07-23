import 'package:flutter/material.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';

class SetupGoalStepOneViewModel extends BaseViewModel {
  final TextEditingController heightTextFieldController =
      TextEditingController(text: "5.11");
  final TextEditingController weightTextFieldController =
      TextEditingController(text: "80");

  void onContinue() => NavService.getStarted();
}
