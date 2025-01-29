import 'package:flutter/material.dart';

class Fundo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;

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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;

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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;

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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;

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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;

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
  const CorpoList({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de dados para os botões
    final List<String> items =
        List.generate(5, (index) => "Botão ${index + 1}");

    return Column(
      children: List.generate(
        items.length,
        (index) => CustomPaint(
          painter: Corpo(),
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
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary, // Cor do botão
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Cantos arredondados
                        ),
                      ),
                      child: Text(
                        'B', // Texto no botão
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
