import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController(text: "123456");
  final TextEditingController dobTextFieldController =
      TextEditingController(text: "dd / mm / yyyy");
  final TextEditingController genderTextFieldController =
      TextEditingController(text: "Male");

  void onSignInTap() => NavService.signIn(shouldReplace: true);

  void onContinue() => NavService.getStarted();
}
