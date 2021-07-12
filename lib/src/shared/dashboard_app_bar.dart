import 'package:flutter/material.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';

class DashboardAppBar extends PreferredSize {
  final GestureTapCallback? onDrawerIconTap;
  final GestureTapCallback? onProfileIconTap;

  const DashboardAppBar({this.onDrawerIconTap, this.onProfileIconTap})
      : super(
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
          GestureDetector(
            onTap: onProfileIconTap,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(42 / 2),
                child: Image.asset(
                  Images.pp,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
