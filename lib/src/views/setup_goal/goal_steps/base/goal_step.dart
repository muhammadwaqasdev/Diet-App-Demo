import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:flutter/material.dart';

abstract class GoalStep extends StatelessWidget {
  String get title;
  String get subTitle;
  String get buttonLabel;
  bool validate(Goal goal);
}
