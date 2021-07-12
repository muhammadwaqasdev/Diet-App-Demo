import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_starter_app/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';

class GetStartedViewModel extends BaseViewModel {
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

  void onSetupGoalTap() => NavService.setupGoal();
}
