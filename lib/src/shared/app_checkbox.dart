import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChange;

  AppCheckbox({required this.onChange, this.isChecked = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(!isChecked),
      child: Align(
        alignment: Alignment.topLeft,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          padding: EdgeInsets.all(12),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 150),
            opacity: isChecked ? 1 : 0,
            child: SvgPicture.string(
              '<svg viewBox="32.5 909.5 15.1 9.6" ><path transform="translate(-12372.54, 5056.94)" d="M 12405.037109375 -4141.96875 L 12408.6396484375 -4137.85205078125 L 12420.1240234375 -4147.4404296875" fill="none" stroke="#003441" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    isChecked ? AppColors.activeLightGreen : AppColors.primary),
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.activeLightGreen,
          ),
        ),
      ),
    );
  }
}
