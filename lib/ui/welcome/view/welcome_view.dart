import 'package:aranduapp/ui/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
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
        const SizedBox(height: 80),
        _startButton(context),
        const SizedBox(width: 80),
      ],
    ))));
  }

  Widget _logo(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double circleDiameter = screenSize.height;
    double nameSize = screenSize.height * 0.075;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Círculo de fundo
              Container(
                width: circleDiameter * 0.3,
                height: circleDiameter * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              // Imagem com deslocamento para a esquerda
              Transform.translate(
                offset: const Offset(-10, 0), // Move 30 pixels para a esquerda
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: circleDiameter * 0.24,
                  height: circleDiameter * 0.24,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          // Título "arandú" com fonte amarante
          Text(
            "Arandú",
            style: GoogleFonts.amarante(
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: nameSize,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double paddingHorizontal = screenSize.width * 0.07; // largura da tela
    double paddingVertical = screenSize.height * 0.025; // da altura da tela
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const OnboardingView(),
            ),
          )
        },
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal, vertical: paddingVertical),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              "Começar",
              style: Theme.of(context).textTheme.bodyLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            )),
      ),
    );
  }
}
