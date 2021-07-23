import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:diet_app/src/base/utils/utils.dart';

appInit() {
  locator<SnackbarService>().init();
}
