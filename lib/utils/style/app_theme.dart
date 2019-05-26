import 'package:flutter/material.dart';

abstract class ColorPalette {

  static const Color orange = const Color(0xFFF59423);
  static const Color textBlack = const Color(0xFF4A4A4A);
  static const Color textGray = const Color(0xFF9B9B9B);
  static const Color borderGray = const Color(0xFFE2E2E2);
  static const Color red = const Color(0xFFD32F2F);
  static const Color darkGray = const Color(0xFF757575);
	static const Color lightGray = const Color(0xFFBDBDBD);

}

mixin AppThemeMixin {

  ThemeData get appThemeData => ThemeData(
    primaryColor: ColorPalette.orange,
    indicatorColor: ColorPalette.orange,
    cursorColor: ColorPalette.orange,
    fontFamily: "Avenir",
    textSelectionHandleColor: ColorPalette.orange,
    textSelectionColor: ColorPalette.orange.withOpacity(0.5),
    buttonColor: ColorPalette.orange,
    accentColor: ColorPalette.orange
  );

}