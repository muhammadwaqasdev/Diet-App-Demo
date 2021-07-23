import 'package:flutter/material.dart';
import 'package:diet_app/generated/app_fonts.asset.dart';
import 'package:diet_app/src/styles/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get() => ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: AppColors.primaryBg,
      fontFamily: AppFonts.poppins,
      primaryColor: AppColors.primary,
      primarySwatch: MaterialColor(
        AppColors.primary.value,
        <int, Color>{
          50: AppColors.primary,
          100: AppColors.primary,
          200: AppColors.primary,
          300: AppColors.primary,
          400: AppColors.primary,
          500: AppColors.primary,
          600: Color(AppColors.primary.value),
          700: AppColors.primary,
          800: AppColors.primary,
          900: AppColors.primary,
        },
      ),
      colorScheme: AppColors.lightScheme,
      brightness: Brightness.light,
      textTheme: _textTheme);

  static TextTheme get _textTheme => TextTheme(
      headline1: TextStyle(
        fontSize: 59,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            color: const Color(0x29000000),
            offset: Offset(0, 6),
            blurRadius: 14,
          )
        ],
      ),
      headline2: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        fontSize: 10,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        fontSize: 10,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      subtitle1: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      button: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ));
}
/*
SAMPLING Area

*/