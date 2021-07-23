import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/remote/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class DashboardDrawer extends StatelessWidget {
  final Function? onDrawerCloseTap;
  final bool isGoalSetup;

  const DashboardDrawer({this.onDrawerCloseTap, this.isGoalSetup = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: (MediaQuery.of(context).padding.top + 4)),
      color: AppColors.primary,
      height: context.screenSize().height,
      child: Column(
        children: [
          _iconControl(context,
              icon: Images.icDrawerClose,
              size: Size(23, 23),
              onTap: this.onDrawerCloseTap),
          VerticalSpacing(140),
          if (this.isGoalSetup)
            _iconControl(context,
                icon: Images.icHome,
                size: Size(38, 36),
                onTap: this.onDrawerCloseTap),
          if (this.isGoalSetup)
            _iconControl(context,
                icon: Images.icAchievement, size: Size(38, 44), onTap: () {
              if (onDrawerCloseTap != null) {
                onDrawerCloseTap!();
              }
              NavService.achievements();
            }),
          _iconControl(context,
              icon: Images.icProfile, size: Size(38, 38), onTap: () {}),
          _iconControl(context,
              icon: Images.icSettings, size: Size(41, 41), onTap: () {}),
          Spacer(),
          _iconControl(context,
              icon: Images.icLogout,
              size: Size(41, 41),
              onTap: locator<FirebaseService>().signOut),
        ],
      ),
    );
  }

  Widget _iconControl(BuildContext context,
          {Function? onTap, required String icon, required Size size}) =>
      InkTouch(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: 100,
              child: Image.asset(
                icon,
                width: size.width,
                height: size.height,
                color: Colors.white,
              )));
}
