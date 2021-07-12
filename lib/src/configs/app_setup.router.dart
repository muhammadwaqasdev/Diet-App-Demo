// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../views/achievements/achievements_view.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/get_started/get_started_view.dart';
import '../views/setup_goal/setup_goal_view.dart';
import '../views/sign_in/sign_in_view.dart';
import '../views/sign_up/sign_up_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String signInView = '/sign-in-view';
  static const String signUpView = '/sign-up-view';
  static const String getStartedView = '/get-started-view';
  static const String setupGoalView = '/setup-goal-view';
  static const String dashboardView = '/dashboard-view';
  static const String achievementsView = '/achievements-view';
  static const all = <String>{
    splashView,
    signInView,
    signUpView,
    getStartedView,
    setupGoalView,
    dashboardView,
    achievementsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.getStartedView, page: GetStartedView),
    RouteDef(Routes.setupGoalView, page: SetupGoalView),
    RouteDef(Routes.dashboardView, page: DashboardView),
    RouteDef(Routes.achievementsView, page: AchievementsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    SignInView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SignInView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SignUpView(),
        settings: data,
      );
    },
    GetStartedView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => GetStartedView(),
        settings: data,
      );
    },
    SetupGoalView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SetupGoalView(),
        settings: data,
      );
    },
    DashboardView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => DashboardView(),
        settings: data,
      );
    },
    AchievementsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => AchievementsView(),
        settings: data,
      );
    },
  };
}
