import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/keyboard_service.dart';
import 'package:diet_app/src/services/remote/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class SignInViewModel extends ReactiveViewModel {
  final firebaseService = locator<FirebaseAuthService>();
  final keyboardService = locator<KeyboardService>();
  final scnakbarService = locator<SnackbarService>();

  bool get isKeyboardVisible => keyboardService.isKeyboardVisible;

  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController();

  void onSignUpTap() => NavService.signUp(shouldReplace: true);

  void onContinue(BuildContext context) async {
    try {
      setBusy(true);
      context.closeKeyboardIfOpen();
      await firebaseService.signInWithEmail(
          emailTextFieldController.text, passwordTextFieldController.text);
    } on FlutterError catch (error) {
      scnakbarService.showErrorMessage(error.message);
    } catch (e) {
      print(e);
    } finally {
      setBusy(false);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [keyboardService];
}
