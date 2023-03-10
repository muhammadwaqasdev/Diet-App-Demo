import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/local/connectivity_service.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/keyboard_service.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:diet_app/src/services/local/local_notification_service.dart';
import 'package:diet_app/src/services/remote/api_service.dart';
import 'package:diet_app/src/services/remote/firebase_auth_service.dart';
import 'package:diet_app/src/views/achievements/achievements_view.dart';
import 'package:diet_app/src/views/dashboard/dashboard_view.dart';
import 'package:diet_app/src/views/get_started/get_started_view.dart';
import 'package:diet_app/src/views/grocery_list/grocery_list_view.dart';
import 'package:diet_app/src/views/profile/profile_view.dart';
import 'package:diet_app/src/views/settings/settings_view.dart';
import 'package:diet_app/src/views/setup_goal/setup_goal_view.dart';
import 'package:diet_app/src/views/sign_in/sign_in_view.dart';
import 'package:diet_app/src/views/sign_up/sign_up_view.dart';
import 'package:diet_app/src/views/splash/splash_view.dart';
import 'package:diet_app/src/views/video/video_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/remote/videos_service.dart';

@StackedApp(routes: [
  CupertinoRoute(page: SplashView, initial: true),
  CupertinoRoute(page: SignInView),
  CupertinoRoute(page: SignUpView),
  CupertinoRoute(page: GetStartedView),
  CupertinoRoute(page: SetupGoalView),
  CupertinoRoute(page: DashboardView),
  CupertinoRoute(page: AchievementsView),
  CupertinoRoute(page: ProfileView),
  CupertinoRoute(page: SettingsView),
  CupertinoRoute(page: VideoView),
  CupertinoRoute(page: GroceryListView),
], dependencies: [
  // Lazy singletons
  LazySingleton(classType: LocalNotificationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: ConnectivityService),
  LazySingleton(classType: KeyboardService),
  LazySingleton(classType: ApiService),
  LazySingleton(classType: FirebaseAuthService),
  LazySingleton(classType: GoalCreationStepsService),
  LazySingleton(classType: LocalDatabaseService),
  LazySingleton(classType: VideosService),
])
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
