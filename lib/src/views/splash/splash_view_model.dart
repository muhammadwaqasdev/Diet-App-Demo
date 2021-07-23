import 'package:carousel_slider/carousel_controller.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/services/remote/firebase_service.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  final bool isInit;

  SplashViewModel(this.isInit);

  List<int> get slides => [1, 2, 3, 4, 5];
  CarouselController buttonCarouselController = CarouselController();

  int _currentSlideIndex = 0;
  int get currentSlideIndex => this._currentSlideIndex;

  init() async {
    setBusy(true);
    var isLoggedIn = await (locator<FirebaseService>()).init();
    if (isLoggedIn) {
      NavService.getStarted();
    }
    setBusy(false);
  }

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

  void onSignInTap() => NavService.signIn();

  void onSignUpTap() => NavService.signUp();
}
