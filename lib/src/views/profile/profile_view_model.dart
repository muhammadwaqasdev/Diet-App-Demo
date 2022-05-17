import 'dart:io';

import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/app_user.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/remote/firebase_auth_service.dart';
import 'package:diet_app/src/styles/app_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  final _firebaseService = locator<FirebaseAuthService>();
  final _authService = locator<AuthService>();
  final scnakbarService = locator<SnackbarService>();

  final TextEditingController fullNameTextFieldController =
      TextEditingController();
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController dobTextFieldController = TextEditingController();
  late TextEditingController genderTextFieldController;

  List<String> get genders => ["Male", "Female"];

  File? selectedImage;
  DateTime? selectedDob;
  late String selectedGender;

  late AppUser user;

  ProfileViewModel() : super() {
    user = AppUser.fromJson(_authService.user!.toJson());
    selectedDob = user.dateOfBirth;
    fullNameTextFieldController.text = user.fullName ?? "";
    emailTextFieldController.text = user.email ?? "";
    dobTextFieldController.text = DateFormat('d / M / y').format(selectedDob!);
    genderTextFieldController = TextEditingController(text: user.gender);
    selectedGender = genderTextFieldController.text;
  }

  void openDatePicker(BuildContext context) async {
    selectedDob = await showRoundedDatePicker(
        context: context,
        theme: AppTheme.get(),
        initialDate: selectedDob,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        borderRadius: 16,
        height: context.screenSize().height / 2);
    dobTextFieldController.text =
        selectedDob != null ? DateFormat('d / M / y').format(selectedDob!) : '';
    notifyListeners();
    context.closeKeyboardIfOpen();
  }

  void onGenderSelected(int index) {
    String selectedGender = genders[index];
    genderTextFieldController.text = selectedGender;
    user.gender = selectedGender;
    notifyListeners();
  }

  onContinue(BuildContext context) async {
    if (Form.of(context)?.validate() ?? false) {
      setBusy(true);
      context.closeKeyboardIfOpen();
      try {
        user.fullName = fullNameTextFieldController.text;
        await _firebaseService.updateProfile(user, selectedImage);
        await Future.delayed(Duration(milliseconds: 1000));
        scnakbarService.showSnackbar(message: "Profile Updated!");
        //await _firebaseService.signUpWithEmail(user, passwordTextFieldController.text, selectedImage);
      } on FlutterError catch (error) {
        scnakbarService.showErrorMessage(error.message);
      } catch (e) {
        print(e);
      } finally {
        setBusy(false);
      }
    }
  }

  void uploadImage(File value) {
    selectedImage = value;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
