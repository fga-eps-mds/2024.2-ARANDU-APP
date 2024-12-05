import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/core/theme/style/app_colors.dart';

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
      title28: _baseTextStyle('Amarante', 26, colors.tituloApp),
      title26: _baseTextStyle('Amarante', 24, colors.tituloApp),
      title24: _baseTextStyle('Amarante', 22, colors.tituloApp),
      title22: _baseTextStyle('Amarante', 20, colors.tituloApp),
      subtitle22: _baseTextStyle('Dosis', 22, colors.subText),
      subtitle20: _baseTextStyle('Dosis', 20, colors.subText),
      subtitle18: _baseTextStyle('Dosis', 18, colors.subText),
      subtitle16: _baseTextStyle('Dosis', 16, colors.subText),
      text16: _baseTextStyle('Comfortaa', 16, colors.subText),
      text14: _baseTextStyle('Comfortaa', 14, colors.subText),
      text12: _baseTextStyle('Comfortaa', 12, colors.subText),
      text10: _baseTextStyle('Comfortaa', 10, colors.subText),
    );
  }

  static _Typography _darkTypography(BuildContext context) {
    final colors = AppColors.current;
    return _Typography(
      title28: _baseTextStyle('Amarante', 26, colors.tituloApp),
      title26: _baseTextStyle('Amarante', 24, colors.tituloApp),
      title24: _baseTextStyle('Amarante', 22, colors.tituloApp),
      title22: _baseTextStyle('Amarante', 20, colors.tituloApp),
      subtitle22: _baseTextStyle('Dosis', 22, colors.subText),
      subtitle20: _baseTextStyle('Dosis', 20, colors.subText),
      subtitle18: _baseTextStyle('Dosis', 18, colors.subText),
      subtitle16: _baseTextStyle('Dosis', 16, colors.subText),
      text16: _baseTextStyle('Comfortaa', 16, colors.subText),
      text14: _baseTextStyle('Comfortaa', 14, colors.subText),
      text12: _baseTextStyle('Comfortaa', 12, colors.subText),
      text10: _baseTextStyle('Comfortaa', 10, colors.subText),
    );
  }

  static TextStyle _baseTextStyle(
      String fontFamily, double? fontSize, Color color) {
    switch (fontFamily) {
      case 'Amarante':
        return GoogleFonts.amarante(fontSize: fontSize, color: color);
      case 'Dosis':
        return GoogleFonts.dosis(fontSize: fontSize, color: color);
      case 'Comfortaa':
        return GoogleFonts.comfortaa(fontSize: fontSize, color: color);
      default:
        return TextStyle(
            fontFamily: fontFamily, fontSize: fontSize, color: color);
    }
  }
}

class _Typography {
  final TextStyle title28;
  final TextStyle title26;
  final TextStyle title24;
  final TextStyle title22;
  final TextStyle subtitle22;
  final TextStyle subtitle20;
  final TextStyle subtitle18;
  final TextStyle subtitle16;
  final TextStyle text16;
  final TextStyle text14;
  final TextStyle text12;
  final TextStyle text10;

  _Typography({
    required this.title28,
    required this.title26,
    required this.title24,
    required this.title22,
    required this.subtitle22,
    required this.subtitle20,
    required this.subtitle18,
    required this.subtitle16,
    required this.text16,
    required this.text14,
    required this.text12,
    required this.text10,
  });
}
