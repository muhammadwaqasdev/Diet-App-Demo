import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  final double size;
  final Brightness? brightness;

  const AppProgressIndicator({this.size = 25, this.brightness});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
            brightness == null || brightness == Brightness.light
                ? Colors.white
                : AppColors.primary),
      ),
    );
  }
}
