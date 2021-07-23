import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/src/app/app_view.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/flavor_service.dart';
import 'package:package_info/package_info.dart';

import 'src/configs/app_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // getting package
  final package = await PackageInfo.fromPlatform();

  setupLocator();
  appInit();
  // app flavor init
  FlavorService.init(package);

  runApp(AppView());
}
