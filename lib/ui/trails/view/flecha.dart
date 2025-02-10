import 'package:flutter/material.dart';

class Fundo extends CustomPainter {
  final ColorScheme colors;
  Fundo(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = colors.onInverseSurface;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, (size.height * 4 / 5))
      ..lineTo(size.width * 1 / 4, size.height)
      ..lineTo(size.width * 3 / 4, size.height)
      ..lineTo(size.width, (size.height * 4 / 5))
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 1 / 2, (size.height * 2 / 5))
      ..close();

    final shadowPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, (size.height * 4 / 5))
      ..lineTo(size.width * 1 / 4, size.height)
      ..lineTo(size.width * 1 / 2, (size.height * 4 / 5))
      ..lineTo(size.width * 3 / 4, size.height)
      ..lineTo(size.width, (size.height * 4 / 5))
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 1 / 2, (size.height * 2 / 5))
      ..close();

    canvas.drawShadow(shadowPath, colors.shadow, 10.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Corpo extends CustomPainter {
  final ColorScheme colors;
  Corpo(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = colors.onInverseSurface;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    final shadowPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();

    canvas.drawShadow(shadowPath, colors.shadow, 10.0, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Ponta extends CustomPainter {
  final ColorScheme colors;
  Ponta(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = colors.onInverseSurface;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 1 / 2, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    final shadowPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 1 / 2, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(0, 0)
      ..close();

    canvas.drawShadow(shadowPath, colors.shadow, 10.0, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
