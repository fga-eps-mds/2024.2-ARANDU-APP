import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // Definindo o fundo branco
        body: Padding(
          padding: const EdgeInsets.all(
              20.0), // Adicionando um pouco de espaço nas laterais
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Movendo o conteúdo para o topo
            children: [
              // Texto de boas-vindas
              Align(
                alignment: Alignment.center, // Centralizando o texto
                child: Text(
                  "Olá\n Bem-vindo ao Arandu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign
                      .center, // Garantindo que o texto seja centralizado
                ),
              ),
              SizedBox(height: 40),

              // Primeiro campo de texto
              Container(
                width: 315,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: InputBorder.none, // Removendo a borda
                    filled: true,
                    fillColor: Color(0xfff7f8f8), // Cor de fundo do campo
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaçamento entre os campos de texto

              // Segundo campo de texto
              Container(
                width: 315,
                child: TextField(
                  obscureText: true, // Torna o campo de senha oculto
                  decoration: InputDecoration(
                    hintText: "Senha",
                    border: InputBorder.none, // Removendo a borda
                    filled: true,
                    fillColor: Color(0xfff7f8f8), // Cor de fundo do campo
                  ),
                ),
              ),
              SizedBox(
                  height: 20), // Espaçamento entre o campo de senha e o botão

              // Botão com gradiente
              GestureDetector(
                onTap: () {
                  print("Botão pressionado!");
                },
                child: Container(
                  width: 315,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFfb923c), // Cor laranja
                        Color(0xFFc2410c), // Cor laranja mais escuro
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
