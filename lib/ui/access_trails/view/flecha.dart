import 'package:flutter/material.dart';

class Fundo extends CustomPainter {
  final ColorScheme colors;
  Fundo(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = colors.onInverseSurface;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height)
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Square extends CustomPainter {
  final ColorScheme colors;
  Square(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = colors.onInverseSurface;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Base extends CustomPainter {
  final ColorScheme colors;
  Base(this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = colors.onInverseSurface;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 1 / 4, size.height)
      ..lineTo(size.width * 3 / 4, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

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
      ..moveTo(size.width * 1 / 4, 0)
      ..lineTo(size.width * 1 / 4, size.height)
      ..lineTo(size.width * 3 / 4, size.height)
      ..lineTo(size.width * 3 / 4, 0)
      ..lineTo(size.width * 1 / 4, 0);

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
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CorpoList extends StatelessWidget {
  const CorpoList({super.key, required this.colors});
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    // Lista de dados para os botões
    final List<String> items =
        List.generate(5, (index) => "Botão ${index + 1}");

    return Column(
      children: List.generate(
        items.length,
        (index) => CustomPaint(
          painter: Corpo(colors),
          child: SizedBox(
            height: 100,
            width: 200,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 75,
                    height: 75,
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação ao pressionar o botão
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(37.5),
                        ),
                      ),
                      child: Text(
                        'B',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
