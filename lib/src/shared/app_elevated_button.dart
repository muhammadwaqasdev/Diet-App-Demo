import 'package:diet_app/src/shared/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class AppElevatedButton extends StatefulWidget {
  final dynamic child;
  final GestureTapCallback onTap;
  final Widget? icon;
  final bool isLarge;
  final bool isFlat;
  final bool isLoading;
  final bool isEnabled;

  const AppElevatedButton(
      {required this.child,
      required this.onTap,
      this.icon,
      this.isLarge = false,
      this.isLoading = false,
      this.isFlat = false,
      this.isEnabled = true});

  const AppElevatedButton.withIcon(
      {required this.child,
      required this.onTap,
      this.icon,
      this.isLarge = true,
      this.isLoading = false,
      this.isFlat = false,
      this.isEnabled = true});

  const AppElevatedButton.flat(
      {required this.child,
      required this.onTap,
      this.icon,
      this.isLarge = false,
      this.isLoading = false,
      this.isFlat = true,
      this.isEnabled = true});

  @override
  _AppElevatedButtonState createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton>
    with TickerProviderStateMixin {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLarge) {
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
          Center(
            child: InkTouch(
              borderRadius: BorderRadius.circular(widget.isLoading ? 25 : 14.0),
              color: (widget.isFlat
                      ? AppColors.activeLightGreen
                      : AppColors.primary)
                  .withOpacity(widget.isEnabled ? 1 : .5),
              onTap:
                  widget.isLoading || !widget.isEnabled ? null : widget.onTap,
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 500),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: widget.isLoading ? 50 : context.screenSize().width,
                  height: widget.isLoading
                      ? 50
                      : widget.isLarge
                          ? 62
                          : 62,
                  padding: widget.isLoading
                      ? EdgeInsets.all(10)
                      : EdgeInsets.all(!widget.isLarge ? 15 : 20),
                  alignment: widget.isLoading
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: !widget.isLoading
                      ? Row(
                          children: [
                            Expanded(
                                child: (widget.child is Widget)
                                    ? widget.child
                                    : widget.child is String
                                        ? Text(widget.child,
                                            style: context
                                                .textTheme()
                                                .button
                                                ?.copyWith(
                                                    color: widget.isFlat
                                                        ? AppColors.primary
                                                        : Colors.white),
                                            textAlign: !widget.isLarge
                                                ? TextAlign.center
                                                : TextAlign.start)
                                        : SizedBox.shrink()),
                            if (widget.icon != null)
                              Image.asset(
                                Images.icRightArrow,
                                width: 23,
                                height: 16,
                                fit: BoxFit.contain,
                              )
                          ],
                        )
                      : SizedBox(
                          width: 30,
                          height: 30,
                          child: AppProgressIndicator(size: 30)),
                  decoration: BoxDecoration(
                    boxShadow: [
                      if (!widget.isFlat)
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
          ),
        ],
      );
}
