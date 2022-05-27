import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/configs/app_setup.router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class NavService {
  static NavigationService? _navigationService = locator<NavigationService>();

  // key
  static GlobalKey<NavigatorState>? get key => StackedService.navigatorKey;

  // on generate route
  static Route<dynamic>? Function(RouteSettings) get onGenerateRoute =>
      StackedRouter().onGenerateRoute;

  // General routes
  static void pop() => _navigationService!.popRepeated(1);

  // routes with args
  static Future<dynamic>? splash({bool isInit = true}) =>
      _navigationService!.clearStackAndShow(Routes.splashView,
          arguments: SplashViewArguments(isInit: isInit));

  static Future<dynamic>? signIn(
          {dynamic arguments, bool shouldReplace = false}) =>
      (!shouldReplace
              ? _navigationService!.navigateTo
              : _navigationService!.replaceWith)(Routes.signInView,
          arguments: arguments);

  static Future<dynamic>? signUp(
          {dynamic arguments, bool shouldReplace = false}) =>
      (!shouldReplace
              ? _navigationService!.navigateTo
              : _navigationService!.replaceWith)(Routes.signUpView,
          arguments: arguments);

  static Future<dynamic>? getStarted(
          {dynamic arguments, bool shouldClear = false}) =>
      (!shouldClear
              ? _navigationService!.navigateTo
              : _navigationService!.clearStackAndShow)(Routes.getStartedView,
          arguments: arguments);

  static Future<dynamic>? setupGoal(
          {dynamic arguments, bool shouldReplace = false}) =>
      (!shouldReplace
              ? _navigationService!.navigateTo
              : _navigationService!.replaceWith)(Routes.setupGoalView,
          arguments: arguments);

  static Future<dynamic>? dashboard({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.dashboardView, arguments: arguments);

  static Future<dynamic>? achievements({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.achievementsView, arguments: arguments);

  static Future<dynamic>? profile({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.profileView, arguments: arguments);

  static Future<dynamic>? settings({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.settingsView, arguments: arguments);

  static Future<dynamic>? video({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.videoView, arguments: arguments);
}
