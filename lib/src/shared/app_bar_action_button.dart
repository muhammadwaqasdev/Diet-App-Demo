import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/styles/app_colors.dart';

class AppBarActionButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color bgColor;

  const AppBarActionButton(
      {this.onTap,
      this.child,
      this.padding,
      this.bgColor = AppColors.greyBgLight});

  @override
  Widget build(BuildContext context) {
    return InkTouch(
      onTap: onTap ?? NavService.pop,
      color: bgColor,
      borderRadius: BorderRadius.circular(40 / 2),
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.all(10),
        child: child ?? Image.asset(Images.icBackArrow),
        width: 40,
        height: 40,
      ),
    );
    ;
  }
}
