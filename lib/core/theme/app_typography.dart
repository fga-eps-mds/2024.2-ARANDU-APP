import 'package:aranduapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static late _Typography typography;

  static void initialize(BuildContext context) {
    typography = (Theme.of(context).brightness == Brightness.dark)
        ? _darkTypography(context)
        : _lightTypography(context);
  }

  static _Typography get current => typography;

  static _Typography _lightTypography(BuildContext context) {
    final colors = AppColors.current;
    return _Typography(
      titleH1: _baseTextStyle('Amarante', 26, colors.tituloApp),
      titleH2: _baseTextStyle('Amarante', 24, colors.tituloApp),
      titleH3: _baseTextStyle('Amarante', 22, colors.tituloApp),
      titleH4: _baseTextStyle('Amarante', 20, colors.tituloApp),
      subtitleH1: _baseTextStyle('Dosis', 22, colors.subText),
      subtitleH2: _baseTextStyle('Dosis', 20, colors.subText),
      subtitleH3: _baseTextStyle('Dosis', 18, colors.subText),
      subtitleH4: _baseTextStyle('Dosis', 16, colors.subText),
      textH1: _baseTextStyle('Comfortaa', 16, colors.subText),
      textH2: _baseTextStyle('Comfortaa', 14, colors.subText),
      textH3: _baseTextStyle('Comfortaa', 12, colors.subText),
      textH4: _baseTextStyle('Comfortaa', 10, colors.subText),
    );
  }

  static _Typography _darkTypography(BuildContext context) {
    final colors = AppColors.current;
    return _Typography(
      titleH1: _baseTextStyle('Amarante', 26, colors.tituloApp),
      titleH2: _baseTextStyle('Amarante', 24, colors.tituloApp),
      titleH3: _baseTextStyle('Amarante', 22, colors.tituloApp),
      titleH4: _baseTextStyle('Amarante', 20, colors.tituloApp),
      subtitleH1: _baseTextStyle('Dosis', 22, colors.subText),
      subtitleH2: _baseTextStyle('Dosis', 20, colors.subText),
      subtitleH3: _baseTextStyle('Dosis', 18, colors.subText),
      subtitleH4: _baseTextStyle('Dosis', 16, colors.subText),
      textH1: _baseTextStyle('Comfortaa', 16, colors.subText),
      textH2: _baseTextStyle('Comfortaa', 14, colors.subText),
      textH3: _baseTextStyle('Comfortaa', 12, colors.subText),
      textH4: _baseTextStyle('Comfortaa', 10, colors.subText),
    );
  }

  static TextStyle _baseTextStyle(
      String fontFamily, double? fontSize, Color color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
    );
  }
}

class _Typography {
  // Titles
  final TextStyle titleH1;
  final TextStyle titleH2;
  final TextStyle titleH3;
  final TextStyle titleH4;
  final TextStyle subtitleH1;
  final TextStyle subtitleH2;
  final TextStyle subtitleH3;
  final TextStyle subtitleH4;
  final TextStyle textH1;
  final TextStyle textH2;
  final TextStyle textH3;
  final TextStyle textH4;
  _Typography({
    required this.titleH1,
    required this.titleH2,
    required this.titleH3,
    required this.titleH4,
    required this.subtitleH1,
    required this.subtitleH2,
    required this.subtitleH3,
    required this.subtitleH4,
    required this.textH1,
    required this.textH2,
    required this.textH3,
    required this.textH4,
  });
}
