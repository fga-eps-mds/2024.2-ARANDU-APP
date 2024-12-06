import 'package:flutter/material.dart';

class RegisterAccount extends StatelessWidget {
  const RegisterAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabeçalho com padrão de losangos
          Stack(
            children: [
              // Padrão de losangos
              Container(
                height: 100,
                color: Colors.white,
                child: CustomPaint(
                  size: const Size(double.infinity, 100),
                  painter: DiamondPainter(),
                ),
              ),
              // Logotipo centralizado
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'Arandú',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Olá,\nCrie uma conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField('Primeiro Nome'),
                    _buildTextField('Último Nome'),
                    _buildTextField('Email', isEmail: true),
                    _buildTextField('Password', isPassword: true),
                    _buildTextField('Confirm Password', isPassword: true),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            // Ação ao clicar no checkbox
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Para continuar, aceite os termos de privacidade e políticas de uso',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Ação ao clicar no botão de cadastro
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('ou'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {
                        // Ação ao usar o Google
                      },
                      icon: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                        height: 36,
                        width: 36,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Navegar para a tela de login
                      },
                      child: const Text(
                        'Já tem uma conta? faça login',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label,
      {bool isEmail = false, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          hintText: isEmail ? 'Digite seu e-mail' : 'Digite seu $label',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}

// Custom Painter para os losangos
class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 161, 115, 77)
      ..style = PaintingStyle.fill;

    const diamondWidth = 40.0;
    const diamondHeight = 20.0;

    for (double x = -diamondWidth; x < size.width; x += diamondWidth) {
      final path = Path()
        ..moveTo(x + diamondWidth / 2, 0)
        ..lineTo(x + diamondWidth, diamondHeight)
        ..lineTo(x + 3 * diamondWidth / 2, 0)
        ..lineTo(x + diamondWidth, -diamondHeight)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
