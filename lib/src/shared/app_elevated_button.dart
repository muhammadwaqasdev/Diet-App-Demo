import 'package:flutter/material.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/shared/ink_touch.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:adobe_xd/adobe_xd.dart';

class AppElevatedButton extends StatelessWidget {
  final dynamic child;
  final GestureTapCallback onTap;
  final Widget? icon;
  final bool isLarge;
  final bool isFlat;

  const AppElevatedButton(
      {required this.child,
      required this.onTap,
      this.icon,
      this.isLarge = false,
      this.isFlat = false});

  const AppElevatedButton.withIcon(
      {required this.child,
      required this.onTap,
      this.icon,
      this.isLarge = true,
      this.isFlat = false});

  const AppElevatedButton.flat(
      {required this.child,
      required this.onTap,
      this.icon,
      this.isLarge = false,
      this.isFlat = true});

  @override
  Widget build(BuildContext context) {
    if (isLarge) {
      return SizedBox(
        height: 62,
        child: Row(
          children: [Expanded(child: _button(context))],
        ),
      );
    }

    return _button(context);
  }

  Widget _button(BuildContext context) => Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child: InkTouch(
              borderRadius: BorderRadius.circular(14.0),
              color: isFlat ? AppColors.activeLightGreen : AppColors.primary,
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(!isLarge ? 15 : 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                        child: (child is Widget)
                            ? child
                            : child is String
                                ? Text(child,
                                    style: context.textTheme().button?.copyWith(
                                        color: isFlat
                                            ? AppColors.primary
                                            : Colors.white),
                                    textAlign: !isLarge
                                        ? TextAlign.center
                                        : TextAlign.start)
                                : SizedBox.shrink()),
                    if (icon != null)
                      Image.asset(
                        Images.icRightArrow,
                        width: 23,
                        height: 16,
                        fit: BoxFit.contain,
                      )
                  ],
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    if (!isFlat)
                      BoxShadow(
                        color: AppColors.primary.withOpacity(.51),
                        offset: Offset(0, 14),
                        blurRadius: 39,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
