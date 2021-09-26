import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/shared/load_image.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardAppBar extends PreferredSize {
  final GestureTapCallback? onDrawerIconTap;

  const DashboardAppBar({
    this.onDrawerIconTap,
  }) : super(
            child: const SizedBox.shrink(),
            preferredSize: const Size.fromHeight(90));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBg,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: [
          GestureDetector(
            onTap: onDrawerIconTap,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset(
                Images.icDrawerToggle,
                width: 30,
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          if (locator<AuthService>().user != null)
            GestureDetector(
              onTap: onDrawerIconTap,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: LoadImage(
                  locator<AuthService>().user!.displayImageUrl,
                  size: Size(42, 42),
                  isCircle: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
