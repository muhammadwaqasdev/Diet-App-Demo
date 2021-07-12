import 'package:flutter/material.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/services/local/navigation_service.dart';
import 'package:flutter_starter_app/src/shared/ink_touch.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';

class DashboardDrawer extends StatelessWidget {
  final GestureTapCallback? onDrawerCloseTap;

  const DashboardDrawer({this.onDrawerCloseTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: (MediaQuery.of(context).padding.top + 4)),
      color: AppColors.primary,
      height: context.screenSize().height,
      width: 100,
      child: Column(
        children: [
          _iconControl(context,
              icon: Images.icDrawerClose,
              size: Size(23, 23),
              onTap: this.onDrawerCloseTap),
          VerticalSpacing(140),
          _iconControl(context,
              icon: Images.icHome,
              size: Size(38, 36),
              onTap: this.onDrawerCloseTap),
          _iconControl(context, icon: Images.icAchievement, size: Size(38, 44),
              onTap: () {
            if (onDrawerCloseTap != null) {
              onDrawerCloseTap!();
            }
            NavService.achievements();
          }),
          _iconControl(context,
              icon: Images.icProfile, size: Size(38, 38), onTap: () {}),
          _iconControl(context,
              icon: Images.icSettings, size: Size(41, 41), onTap: () {}),
        ],
      ),
    );
  }

  Widget _iconControl(BuildContext context,
          {GestureTapCallback? onTap,
          required String icon,
          required Size size}) =>
      InkTouch(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: 100,
              child:
                  Image.asset(icon, width: size.width, height: size.height)));
}
