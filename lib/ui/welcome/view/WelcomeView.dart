import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class WelcomeView extends StatelessWidget {
  //final WelcomeModel model = WelcomeModel("Arandú","Começar");

  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          
          
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _logo(context),
            const SizedBox(height: 130),
            _startButton(context)          
          ],
        )
        )
        
      )
    );
  }

  Widget _logo(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;

    double circleDiameter = screenSize.height * 0.3; 
    double nameSize = screenSize.height * 0.075;

    return Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //Cículo com gradiente com possível logo sobreposta
            Stack(
              alignment: Alignment.center, 
              children: [



                Container(
                  width: circleDiameter,
                  height: circleDiameter,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),

              ],
            ),
            const SizedBox(height: 20),

            //Titulo "arandú" com fonte amarante 
            Text(
              "Arandú",
              style: GoogleFonts.amarante(
                fontSize: nameSize,
                fontWeight: FontWeight.w500, 
              ),
            ),
                    
          ],
        )
        )
        
      );
  }

  Widget _startButton(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;

    double paddingHorizontal = screenSize.width * 0.05; // 10% da largura da tela
    double paddingVertical = screenSize.height * 0.025; // 5% da altura da tela
    return SingleChildScrollView(
      child: GestureDetector(
              onTap: () => {


              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OnboardingView(),
                ),
              )


              },


              child: Container(
                padding: EdgeInsets.symmetric(horizontal:paddingHorizontal, vertical:paddingVertical),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Começar",
                  style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500, //coloca a fonte certa

                  ),
                )
              ),
          
            ),
    );
  }

  
  
}
