import 'package:flutter/material.dart';

abstract class GoalStep extends StatelessWidget {
  String get title;
  String get subTitle;
  String get buttonLabel;
}
