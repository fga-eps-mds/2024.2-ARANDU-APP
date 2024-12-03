import 'dart:ui';

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('FF');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
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
