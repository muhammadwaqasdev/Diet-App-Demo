import 'dart:math';

import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';

extension UIExt on BuildContext {
  double topSpace() => MediaQuery.of(this).padding.top;
  double appBarHeight() => AppBar().preferredSize.height;
  Size screenSize() => MediaQuery.of(this).size;
  ThemeData appTheme() => Theme.of(this);
  TextTheme textTheme() => Theme.of(this).textTheme;

  void closeKeyboardIfOpen() {
    //FocusScope.of(context).requestFocus(new FocusNode());
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }
}

extension DblExt on double {
  double percent(double percent) => (this / 100) * percent;
}

enum SnackbarType { ERROR }

extension SnackExt on SnackbarService {
  SnackbarConfig get defaultConfigs => SnackbarConfig(
      backgroundColor: AppColors.primary, messageColor: Colors.white);

  SnackbarConfig get errorConfigs => SnackbarConfig(
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: Colors.red,
      messageColor: Colors.white);

  init() {
    registerSnackbarConfig(defaultConfigs);
    registerCustomSnackbarConfig(
        variant: SnackbarType.ERROR, config: errorConfigs);
  }

  showErrorMessage(String message,
      {Duration duration = const Duration(seconds: 5)}) {
    this.showCustomSnackBar(
        message: message,
        variant: SnackbarType.ERROR,
        duration: duration,
        onTap: NavService.pop);
  }
}
