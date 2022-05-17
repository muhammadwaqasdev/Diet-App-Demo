import 'package:carousel_slider/carousel_controller.dart';
import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class GetStartedViewModel extends BaseViewModel
    with VideoPopupScreenViewModelMixin {
  DrawerContainerController drawerContainerController =
      DrawerContainerController();

  List<int> get slides => [1, 2, 3, 4, 5];
  CarouselController buttonCarouselController = CarouselController();

  int _currentSlideIndex = 0;

  int get currentSlideIndex => this._currentSlideIndex;

  set currentSlideIndex(int value) {
    this._currentSlideIndex = value;
    notifyListeners();
  }

  void onPageChanged(int newIndex, dynamic reason) {
    currentSlideIndex = newIndex;
  }

  void onIndicatorTap(int index) {
    buttonCarouselController.jumpToPage(currentSlideIndex);
  }

  void onSetupGoalTap() {
    locator<GoalCreationStepsService>().goal.uid =
        FirebaseAuth.instance.currentUser!.uid;
    NavService.setupGoal();
  }
}
