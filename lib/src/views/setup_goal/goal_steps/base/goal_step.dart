import 'package:diet_app/src/models/goal.dart';
import 'package:flutter/material.dart';

abstract class GoalStep extends StatelessWidget {
  String get title;

  String get subTitle;

  String get buttonLabel;

  bool get overridePageHorizontalPadding => false;

  final double pageHorizontalPadding = 25;

  bool validate(Goal goal);
}
