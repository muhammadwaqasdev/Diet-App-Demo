import 'dart:io';

import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/app_user.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/services/remote/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel
    with VideoPopupScreenViewModelMixin {
  final firebaseService = locator<FirebaseAuthService>();
  final scnakbarService = locator<SnackbarService>();

  List<String> get genders => ["Male", "Female"];

  final AppUser user = AppUser();

  final TextEditingController fullNameTextFieldController =
      TextEditingController();
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final TextEditingController dobTextFieldController = TextEditingController();
  late TextEditingController genderTextFieldController;

  File? selectedImage;
  DateTime? selectedDob;
  late String selectedGender;

  SignUpViewModel() : super() {
    genderTextFieldController = TextEditingController(text: genders.first);
    selectedGender = genderTextFieldController.text;
    user.gender = selectedGender;
    fullNameTextFieldController
        .addListener(() => user.fullName = fullNameTextFieldController.text);
    emailTextFieldController
        .addListener(() => user.email = emailTextFieldController.text);
    dobTextFieldController.addListener(() => user.dateOfBirth = selectedDob);
    genderTextFieldController.addListener(() => user.gender = selectedGender);
  }

  void onSignInTap() => NavService.signIn(shouldReplace: true);

  void onContinue(BuildContext context) async {
    if (Form.of(context)?.validate() ?? false) {
      setBusy(true);
      context.closeKeyboardIfOpen();
      try {
        await firebaseService.signUpWithEmail(
            context, user, passwordTextFieldController.text, selectedImage);
      } on FlutterError catch (error) {
        scnakbarService.showErrorMessage(error.message);
      } catch (e) {
        print(e);
      } finally {
        setBusy(false);
      }
    }
  }

  void onDateChange(DateTime value) {
    selectedDob = value;
    user.dateOfBirth = value;
    notifyListeners();
  }

  void onGenderSelected(int index) {
    String selectedGender = genders[index];
    genderTextFieldController.text = selectedGender;
    user.gender = selectedGender;
    notifyListeners();
  }

  void uploadImage(File value) {
    selectedImage = value;
    notifyListeners();
  }
}
