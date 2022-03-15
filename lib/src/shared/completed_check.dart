import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CompletedCheck extends StatelessWidget {
  final bool isChecked;

  const CompletedCheck({required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      alignment: Alignment.center,
      padding: EdgeInsets.all(7),
      width: 33,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33 / 2),
        color: isChecked ? AppColors.progressGreen : AppColors.greyBorder,
      ),
      child: Image.asset(Images.icCheck),
    );
    ;
  }
}
