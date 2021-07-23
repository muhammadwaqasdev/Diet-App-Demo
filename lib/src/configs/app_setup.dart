import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/local/connectivity_service.dart';
import 'package:diet_app/src/services/local/keyboard_service.dart';
import 'package:diet_app/src/services/remote/api_service.dart';
import 'package:diet_app/src/services/remote/firebase_service.dart';
import 'package:diet_app/src/views/achievements/achievements_view.dart';
import 'package:diet_app/src/views/dashboard/dashboard_view.dart';
import 'package:diet_app/src/views/get_started/get_started_view.dart';
import 'package:diet_app/src/views/setup_goal/setup_goal_view.dart';
import 'package:diet_app/src/views/sign_in/sign_in_view.dart';
import 'package:diet_app/src/views/sign_up/sign_up_view.dart';
import 'package:diet_app/src/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  CupertinoRoute(page: SplashView, initial: true),
  CupertinoRoute(page: SignInView),
  CupertinoRoute(page: SignUpView),
  CupertinoRoute(page: GetStartedView),
  CupertinoRoute(page: SetupGoalView),
  CupertinoRoute(page: DashboardView),
  CupertinoRoute(page: AchievementsView),
], dependencies: [
  // Lazy singletons
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: ConnectivityService),
  LazySingleton(classType: KeyboardService),
  LazySingleton(classType: ApiService),
  LazySingleton(classType: FirebaseService),
])
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
