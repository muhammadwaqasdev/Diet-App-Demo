import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/services/remote/firebase_auth_service.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardDrawer extends StatelessWidget {
  final GestureTapCallback? onDrawerCloseTap;
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
          Spacer(),
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
          _iconControl(context, icon: Images.icProfile, size: Size(38, 38),
              onTap: () {
            if (onDrawerCloseTap != null) {
              onDrawerCloseTap!();
            }
            NavService.profile();
          }),
          _iconControl(context, icon: Images.play, size: Size(38, 38),
              onTap: () {
            if (onDrawerCloseTap != null) {
              onDrawerCloseTap!();
            }
            NavService.video();
          }),
          _iconControl(context, icon: Images.icTotalCarbs, size: Size(38, 38),
              onTap: () {
            if (onDrawerCloseTap != null) {
              onDrawerCloseTap!();
            }
            NavService.groceryList();
          }),
          _iconControl(context, icon: Images.icSettings, size: Size(41, 41),
              onTap: () {
            if (onDrawerCloseTap != null) {
              onDrawerCloseTap!();
            }
            NavService.settings();
          }),
          Spacer(),
          _iconControl(context, icon: Images.icLogout, size: Size(41, 41),
              onTap: () async {
            var confirm = await showDialog<bool>(
                context: context,
                builder: (childCtx) => AlertDialog(
                      title: Text("Logging out!",
                          style: context.textTheme().headline2),
                      content: Text(
                          "Would you like to continue logout? this will result in the destruction of your current goal record!",
                          style: context.textTheme().subtitle2),
                      actions: [
                        TextButton(
                          child: Text("Cancel",
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        TextButton(
                          child: Text("Continue"),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                        ),
                      ],
                    ));
            if (confirm ?? false) {
              await locator<FirebaseAuthService>().signOut();
            }
          }),
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
              padding: EdgeInsets.symmetric(
                  vertical: context.screenSize().height < 600 ? 10 : 20),
              width: 100,
              child: Image.asset(
                icon,
                width: size.width,
                height: size.height,
                color: Colors.white,
              )));
}
