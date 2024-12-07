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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 95),

            //Cículo com gradiente com possível logo sobreposta
            Stack(
              alignment: Alignment.center, 
              children: [



                Container(
                  width: 278,
                  height: 278,
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
                fontSize: 60,
                fontWeight: FontWeight.w500, 
              ),
            ),
            const Spacer(),

            //Botão de começar com gradiente
            GestureDetector(
              onTap: () => {


              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OnboardingView(),
                ),
              )


              },


              child: Container(
                padding: const EdgeInsets.symmetric(horizontal:120, vertical: 15),
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
            const SizedBox(height:50),          
          ],
        )
      )
    );
  }
  
}
