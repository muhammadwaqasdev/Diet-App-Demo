import 'package:flutter/material.dart';

class InkTouch extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;
  final Color? color;
  final Color? splashColor;
  final BorderRadius? borderRadius;

  InkTouch(
      {required this.onTap,
      this.child,
      this.color,
      this.borderRadius,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap ?? null,
        child: child,
      ),
    );
  }
}
