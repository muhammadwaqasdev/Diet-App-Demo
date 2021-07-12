import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF003441);
  static const Color primaryBg = Color(0xFFFCFCFC);
  static const Color greyBorder = Color(0xFFEBEBEB);
  static const Color greyBg = Color(0xFFE2E2E2);
  static const Color greyBgDark = Color(0xFFD9D9D9);
  static const Color greyBgLight = Color(0xFFF3F3F5);
  static const Color greyBgDarker = Color(0xFFDCDCDC);
  static const Color greyBgDarkest = Color(0xFF989898);
  static const Color greySubTitle = Color(0xFF888888);
  static const Color greyDarkBgBorderColor = Color(0xFFEEEEEE);
  static const Color activeLightGreen = Color(0xFFEAFAB0);
  static const Color activeBorderLightGreen = Color(0xFFE8F9AB);
  static const Color progressGreen = Color(0xFF6CD924);

  static const Color protienLightPurple = Color(0xFFF6F8FE);
  static const Color protienPurple = Color(0xFFB9B6FF);

  static const Color carbsLightGreen = Color(0xFFF0FAF5);
  static const Color carbsGreen = Color(0xFF74C9A0);

  static const Color fatsLightBlue = Color(0xFFF2F9FB);
  static const Color fatsBlue = Color(0xFF85C7FA);

  static ColorScheme get lightScheme => ColorScheme.light(primary: primary);
}
