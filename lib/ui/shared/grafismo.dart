import 'package:flutter/material.dart';

class CustomPatternPainter extends CustomPainter {
  final ColorScheme colors;
  CustomPatternPainter(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colors.primary
      ..style = PaintingStyle.fill;

    double tileWidth = 50.0; // Largura fixa dos losangos
    double tileHeight = 30.0; // Altura fixa dos losangos
    int columns = (size.width / tileWidth).floor();

    Path path = Path();

    double x = 0;

    for (int i = 0; i < columns; i++) {
      if (i == 0) {
        x = 0;
      } else {
        x = x + (tileWidth * 2);
      }

      path.moveTo(x, 0);
      path.lineTo(x + (tileWidth / 2), 0);
      path.lineTo(x, (tileHeight / 2) - 2);
      path.lineTo(x, 0);
      path.close();

      path.moveTo(x + tileWidth / 2, tileHeight / 2);
      path.lineTo(x + tileWidth, 0);
      path.lineTo(x + tileWidth * 3 / 2, tileHeight / 2);
      path.lineTo(x + tileWidth, tileHeight);
      path.close();

      path.moveTo(x + (tileWidth * 3 / 2), 0);
      path.lineTo(x + tileWidth * 2, 0);
      path.lineTo(x + tileWidth * 2, (tileHeight / 2) - 2);
      path.lineTo(x + (tileWidth * 3 / 2), 0);
      path.close();

      path.moveTo(x, (tileHeight / 2));
      path.lineTo(x, (tileHeight * 3 / 2));
      path.lineTo(x + (tileWidth / 2), tileHeight);
      path.moveTo(x, (tileHeight / 2));
      path.close();

      path.moveTo(x + tileWidth * 2, (tileHeight / 2));
      path.lineTo(x + tileWidth * 2, (tileHeight * 3 / 2));
      path.lineTo(x + (tileWidth * 3 / 2), tileHeight);
      path.moveTo(x + tileWidth * 2, (tileHeight / 2));
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
