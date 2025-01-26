import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onExit;

  const ErrorScreen({super.key, required this.onRetry, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset(
                  'assets/gif/alert_animation.json',
                  repeat: true,
                  animate: true,
                ),
              ),
              const SizedBox(height: 20),

              // Título
              const Text(
                "Algo deu errado...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Mensagem de erro
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "Erro ao carregar as informações.\nPor favor, tente atualizar a página ou verificar sua conexão com a internet.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Botão de atualizar
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  "Atualizar",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),

              // Botão de sair do aplicativo
              TextButton(
                onPressed: onExit,
                child: const Text(
                  "Sair do aplicativo",
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
