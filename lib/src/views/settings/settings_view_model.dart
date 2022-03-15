import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/remote/firebase_auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends ReactiveViewModel {
  final firebaseService = locator<FirebaseAuthService>();
  final scnakbarService = locator<SnackbarService>();
  final _authService = locator<AuthService>();

  final TextEditingController passwordTextFieldController =
      TextEditingController();

  final TextEditingController newPasswordTextFieldController =
      TextEditingController();

  void onContinue(BuildContext context) async {
    if (Form.of(context)?.validate() ?? false) {
      setBusy(true);
      context.closeKeyboardIfOpen();
      try {
        //await firebaseService.signUpWithEmail( user, passwordTextFieldController.text, selectedImage);
        await Future.delayed(Duration(milliseconds: 500));
        await firebaseService.updatePassword(
            _authService.user?.email ?? "",
            passwordTextFieldController.text,
            newPasswordTextFieldController.text);
        await Future.delayed(Duration(milliseconds: 500));
        scnakbarService.showSnackbar(message: "Password Updated!");
        passwordTextFieldController.text = "";
        newPasswordTextFieldController.text = "";
      } on FlutterError catch (error) {
        scnakbarService.showErrorMessage(error.message);
      } catch (e) {
        scnakbarService.showErrorMessage(e.toString().split("] ").last);
        print(e);
      } finally {
        setBusy(false);
      }
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
