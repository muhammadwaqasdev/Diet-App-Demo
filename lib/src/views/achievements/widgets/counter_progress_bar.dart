import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';

class CounterProgressBar extends StatelessWidget {
  final int total;
  final int progress;
  final Color inactiveColor;
  final Color activeColor;
  final double height;

  const CounterProgressBar(
      {required this.total,
      required this.progress,
      this.inactiveColor = Colors.white,
      this.activeColor = AppColors.activeLightGreen,
      this.height = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(total, (index) => index + 1)
            .map((idx) => Expanded(
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(right: idx == total ? 0 : 7),
                    duration: Duration(milliseconds: 250),
                    height: height,
                    decoration: BoxDecoration(
                        color: progress >= idx ? activeColor : inactiveColor,
                        borderRadius: BorderRadius.circular(height / 2)),
                  ),
                ))
            .toList());
  }
}
