import 'package:flutter/material.dart';

abstract class ColorPalette {

  static const Color orange = const Color(0xFFF59423);
  static const Color textBlack = const Color(0xFF4A4A4A);
  static const Color textGray = const Color(0xFF9B9B9B);
  static const Color borderGray = const Color(0xFFE2E2E2);

}

mixin AppThemeMixin {

  ThemeData get appThemeData => new ThemeData(
    primaryColor: ColorPalette.orange,
    indicatorColor: ColorPalette.orange,
    fontFamily: "Avenir",
  );

}