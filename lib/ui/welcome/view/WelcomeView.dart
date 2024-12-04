import 'package:flutter/material.dart';
import 'package:aranduapp/ui/welcome/viewModel/WelcomeViewModel.dart';
import 'package:google_fonts/google_fonts.dart';


class WelcomeSreen extends StatelessWidget {
  final WelcomeViewModel viewModel = WelcomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 95),

            //Cículo com gradiente com possível logo sobreposta
            Stack(
              alignment: Alignment.center, //centraliza logo no cículo
              children: [
                Container(
                  width: 278,
                  height: 278,
                  decoration: BoxDecoration(
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
            SizedBox(height: 20),

            //Titulo "arandú" com fonte amarante 
            Text(
              viewModel.title,
              style: GoogleFonts.amarante(
                fontSize: 60,
                fontWeight: FontWeight.w500, 
              ),
            ),
            Spacer(),

            //Botão de começar com gradiente
            GestureDetector(
              onTap: () => viewModel.navigateToNextPage(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:120, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFB923C),
                      Color(0xFFC2410C),
                    ], 
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Text(
                  viewModel.buttonText,
                  style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500, //coloca a fonte certa

                  ),
                )
              ),
          
            ),
            SizedBox(height:50),          
          ],
        )
      )
    );
  }
}