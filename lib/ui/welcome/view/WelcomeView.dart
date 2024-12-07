import 'package:flutter/material.dart';
import 'package:aranduapp/ui/welcome/model/WelcomeModel.dart';
import 'package:google_fonts/google_fonts.dart';


class WelcomeView extends StatelessWidget {
  final WelcomeModel model = WelcomeModel("Arandú","Começar");

  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 95),

            //Cículo com gradiente com possível logo sobreposta
            Stack(
              alignment: Alignment.center, //centraliza logo no cículo
              children: [
                Container(
                  width: 278,
                  height: 278,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors:[
                        Color(0xFFFB923C),
                        Color(0xFFC2410C),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
                // comentado: Local onde a logo pode ser adicionada no futuro (CircleAvatar todo)
                //CircleAvatar(
                // radius: 100, 
                //  backgroundImage: AssetImage('//colocar a logo png'),
                // ),
              ],
            ),
            const SizedBox(height: 20),

            //Titulo "arandú" com fonte amarante 
            Text(
              model.title,
              style: GoogleFonts.amarante(
                fontSize: 60,
                fontWeight: FontWeight.w500, 
              ),
            ),
            const Spacer(),

            //Botão de começar com gradiente
            GestureDetector(
              onTap: () => navigateToNextPage(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal:120, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFB923C),
                      Color(0xFFC2410C),
                    ], 
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Text(
                  model.buttonText,
                  style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500, //coloca a fonte certa

                  ),
                )
              ),
          
            ),
            const SizedBox(height:50),          
          ],
        )
      )
    );
  }
  
  void navigateToNextPage(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }
}