import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class GoalStepProgressBar extends StatefulWidget {
  final int progress;
  final int total;
  final Color color;
  final Color bgColor;
  final double height;

  const GoalStepProgressBar(
      {this.progress = 0,
      this.total = 1,
      this.color = AppColors.primary,
      this.bgColor = AppColors.greyBgDark,
      this.height = 5});

  @override
  _GoalStepProgressBarState createState() => _GoalStepProgressBarState();
}

class _GoalStepProgressBarState extends State<GoalStepProgressBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.height / 2)),
        ),
        AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 250),
          child: FractionallySizedBox(
            widthFactor: (widget.progress / widget.total * 100) / 100,
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(5 / 2)),
            ),
          ),
        ),
      ],
    );
  }
}
