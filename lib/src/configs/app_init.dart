import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/configs/flipper_init.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:diet_app/src/services/local/local_notification_service.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

appInit() async {
  locator<SnackbarService>().init();
  await locator<LocalNotificationService>().init();
  await locator<LocalDatabaseService>().init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      statusBarBrightness: Brightness.dark));
  FlipperInit.init();
  //Stetho.initialize();
}
