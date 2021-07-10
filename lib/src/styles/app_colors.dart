import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color primary = Color(0xFF003441);
  static Color greyBorder = Color(0xFFEBEBEB);
  static Color greyBg = Color(0xFFE2E2E2);
  static Color greyBgDark = Color(0xFFD9D9D9);
  static Color greyBgLight = Color(0xFFF3F3F5);
  static Color greyBgDarker = Color(0xFFDCDCDC);
  static Color activeLightGreen = Color(0xFFEAFAB0);
  static Color activeBorderLightGreen = Color(0xFFE8F9AB);
  static Color progressGreen = Color(0xFF6CD924);

  static Color protienLightPurple = Color(0xFFF6F8FE);
  static Color protienPurple = Color(0xFFB9B6FF);

  static Color carbsLightGreen = Color(0xFFF0FAF5);
  static Color carbsGreen = Color(0xFF74C9A0);

  static Color fatsLightBlue = Color(0xFFF2F9FB);
  static Color fatsBlue = Color(0xFF85C7FA);

  static ColorScheme get lightScheme => ColorScheme.light(primary: primary);
}
