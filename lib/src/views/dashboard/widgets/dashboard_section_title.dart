import 'package:diet_app/src/base/utils/utils.dart';
import 'package:flutter/material.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String text;

  const DashboardSectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          context.textTheme().headline5?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
