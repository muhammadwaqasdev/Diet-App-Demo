import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:stacked/stacked.dart';

class AchievementsViewModel extends ReactiveViewModel {
  final LocalDatabaseService _localDatabaseService =
      locator<LocalDatabaseService>();

  List<DailyIntake> intakes = [];

  DailyIntake get firstIntake => intakes.first;
  DailyIntake get lastIntake => intakes.last;

  int get totlalConsumedCalories => intakes
      .map((intake) => intake.consumedCalories)
      .reduce((v1, v2) => v1 + v2);

  int get totlalProteins =>
      intakes.map((intake) => intake.totalProtein).reduce((v1, v2) => v1 + v2);

  int get totlalCarbs =>
      intakes.map((intake) => intake.totalCarbs).reduce((v1, v2) => v1 + v2);

  int get totlalFats =>
      intakes.map((intake) => intake.totalFats).reduce((v1, v2) => v1 + v2);

  int get totlalConsumedProteins => intakes
      .map((intake) => intake.consumedProtein)
      .reduce((v1, v2) => v1 + v2);

  int get totlalConsumedCarbs =>
      intakes.map((intake) => intake.consumedCarbs).reduce((v1, v2) => v1 + v2);

  int get totlalConsumedFats =>
      intakes.map((intake) => intake.consumedFats).reduce((v1, v2) => v1 + v2);

  init() async {
    setBusy(true);
    intakes = await _localDatabaseService.intakeDao.getAllIntakes();
    notifyListeners();
    setBusy(false);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
