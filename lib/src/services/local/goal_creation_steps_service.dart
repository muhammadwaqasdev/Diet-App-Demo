import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/local_notification_service.dart';
import 'package:diet_app/src/services/remote/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class GoalCreationStepsService with ReactiveServiceMixin {
  ReactiveValue<Goal> _goal = ReactiveValue<Goal>(Goal(
    id: "",
    uid: "",
    heightFt: ReactiveValue(0),
    heightIn: ReactiveValue(0),
    weight: ReactiveValue(0),
    activityLevel: ReactiveValue(1),
    goalTarget: ReactiveValue(GoalTarget.Weight_Loss),
    targetWeight: ReactiveValue(0),
    targetSleep: ReactiveValue(4),
    targetStress: ReactiveValue(1),
    meals: ReactiveValue(Goal.mealSets.keys.first),
    preferredDiet: ReactiveValue(PreferredDiet.Balanced),
    alarmData: ReactiveList.from(Goal.mealSets.values.first),
    dislikedMeals: ReactiveList(),
    additionalIntakePercentage: ReactiveValue(0),
    lastCalculatedIntake: ReactiveValue(0),
    isManualMacrosEntry: ReactiveValue(false),
  ));

  Goal get goal => _goal.value;

  ReactiveValue<int> _loadingStep = ReactiveValue<int>(0);
  int get loadingStep => _loadingStep.value;

  set loadingStep(int value) {
    _loadingStep.value = value;
  }

  GoalCreationStepsService() {
    listenToReactiveValues([
      _goal,
      _goal.value.heightFt,
      _goal.value.heightIn,
      _goal.value.weight,
      _goal.value.activityLevel,
      _goal.value.goalTarget,
      _goal.value.targetWeight,
      _goal.value.targetSleep,
      _goal.value.targetStress,
      _goal.value.preferredDiet,
      _goal.value.alarmData,
      _goal.value.isManualMacrosEntry,
      _loadingStep
    ]);
  }

  set goal(Goal goal) {
    _goal.value = goal;
  }

  save() async {
    this.goal.uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    var existingGoal = await FirestoreService.goals
        .where("uid", isEqualTo: this.goal.uid)
        .get();
    if (existingGoal.docs.isEmpty) {
      var newDoc = FirestoreService.goals.doc();
      this.goal.id = newDoc.id;
    } else {
      this.goal.id = existingGoal.docs.first.id;
    }
    await locator<LocalNotificationService>().schedule(goal);
    await FirestoreService.goals.doc(this.goal.id).set(this.goal);
  }

  Future<bool> fetch() async {
    var existingGoal = await FirestoreService.goals
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? "")
        .get();
    if (existingGoal.docs.isEmpty) {
      return Future.value(false);
    } else {
      _goal.value = existingGoal.docs.first.data();
      return Future.value(true);
    }
  }
}
