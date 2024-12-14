import 'package:flutter/material.dart';

class TrianglesAndRhombus extends StatelessWidget {
  const TrianglesAndRhombus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildPattern(10),
        ),
      ],
    );
  }

  List<Widget> _buildPattern(int count) {
    List<Widget> widgets = [];
    for (int i = 0; i < count; i++) {
      if (i % 2 == 0) {
        widgets.add(CustomPaint(
          size: const Size(40, 40),
          painter: RhombusPainter(offset: 8),
        ));
      } else {
        widgets.add(CustomPaint(
          size: const Size(40, 20),
          painter: InvertedTrianglePainter(),
        ));
      }
    }
    return widgets;
  }
}

class RhombusPainter extends CustomPainter {
  final double offset;

  RhombusPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width / 2, offset);
    path.lineTo(size.width, size.height / 2 + offset);
    path.lineTo(size.width / 2, size.height + offset);
    path.lineTo(0, size.height / 2 + offset);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
