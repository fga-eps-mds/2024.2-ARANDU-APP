import 'package:aranduapp/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppColors {
  static late _Colors colors;
  static late _GradientColors gradients;
  static late _Alerts alerts;
  static void initialize(BuildContext context) {
    colors = (Theme.of(context).brightness == Brightness.dark)
        ? _darkColors()
        : _lightColors();
    gradients = _GradientColors();
    alerts = _Alerts();
  }

  static _Colors get current => colors;
  static _GradientColors get currentGradients => gradients;
  static _Alerts get currentAlerts => alerts;

  static _Colors _lightColors() {
    return _Colors(
      background: fromHex('#FFFFFF'),
      secBackground: fromHex('#ada4a5'),
      tituloApp: fromHex('#1E1E1E'),
      text: fromHex('#000000'),
      subText: fromHex('#7B6F72'),
      textSecBackground: fromHex('#ADA4A5'),
      losang: fromHex('#9a3412'),
      colorDesenho: fromHex('#fed7aa'),
    );
  }

  static _Colors _darkColors() {
    return _Colors(
      background: fromHex('#181818'),
      secBackground: fromHex('#2C2C2C'),
      tituloApp: fromHex('#EBEBEB'),
      text: fromHex('#FFFFFF'),
      subText: fromHex('#F0F0F0'),
      textSecBackground: fromHex('#ADA4A5'),
      losang: fromHex('#fb923c'),
      colorDesenho: fromHex('#c2410b'),
    );
  }
}

class _Colors {
  final Color background;
  final Color secBackground;
  final Color tituloApp;
  final Color text;
  final Color subText;
  final Color textSecBackground;
  final Color losang;
  final Color colorDesenho;

  _Colors({
    required this.background,
    required this.secBackground,
    required this.tituloApp,
    required this.text,
    required this.subText,
    required this.textSecBackground,
    required this.losang,
    required this.colorDesenho,
  });
}

class _GradientColors {
  final LinearGradient orange = LinearGradient(
    colors: [fromHex('#FB923C'), fromHex('#C2410C')],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient cyan = LinearGradient(
    colors: [fromHex('#38CFE3'), fromHex('#0E7490')],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class _Alerts {
  final Color error = fromHex('#C00F0C');
  final Color alert = fromHex('#D4B139');
  final Color success = fromHex('#5A9D4B');
}
