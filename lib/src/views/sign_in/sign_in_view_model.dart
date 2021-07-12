import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController(text: "123456");

  void onSignUpTap() => NavService.signUp(shouldReplace: true);

  void onContinue() => NavService.getStarted();
}
