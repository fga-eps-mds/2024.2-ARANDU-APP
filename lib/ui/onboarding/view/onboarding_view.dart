import 'package:flutter/material.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> steps = [
    {
      'title': 'Bem-Vindo(a)!',
      'description':
          'Seja bem vindo ao Arandu!!! Sou um ambiente voltado para aprendizado de forma gratuita',
      'imageAsset': 'assets/images/Component1.png',
    },
    {
      'title': 'o que você encontra?',
      'description':
          'Aqui você encontrará livros interativos de diversas disciplinas com objetivo de entregar praticidade e qualidade no aprendizado.',
      'imageAsset': 'assets/images/Component2.png',
    },
    {
      'title': 'Como funciona?',
      'description':
          'Para acessar uma trilha basta se inscrever na disciplina de sua preferência e ter acesso aos materiais. \n Bons estudos !!!',
      'imageAsset': 'assets/images/Component3.png',
    },
  ];

  void _goToNextPage() {
    if (_currentPage < steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int page = _pageController.page?.toInt() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double imageHeight = constraints.maxHeight * 0.55;
          final double contentHeight = constraints.maxHeight * 0.55;
          final double buttonHeight = constraints.maxHeight * 0.15;

          return Stack(
            children: [
              // Imagem do Onboarding
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: imageHeight,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Container(
                    key: ValueKey<String>(steps[_currentPage]['imageAsset']!),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(steps[_currentPage]['imageAsset']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // Texto do Onboarding
              Positioned(
                top: imageHeight,
                left: 0,
                right: 0,
                height: contentHeight,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title']!,
                            style: GoogleFonts.comfortaa(
                              textStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                step['description']!,
                                style: GoogleFonts.comfortaa(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Botões de navegação
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: buttonHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Mantém o Pular à esquerda
                    children: [
                      if (_currentPage < steps.length - 1)
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterAccount(),
                              ),
                            );
                          },
                          child: const Text(
                            'Pular',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      if (_currentPage < steps.length - 1)
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5);
                                }
                                return Theme.of(context).colorScheme.primary;
                              },
                            ),
                          ),
                          onPressed: _goToNextPage,
                          child: const Text(
                            'Avançar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if (_currentPage == steps.length - 1)
                        // Alteração aqui: Mover o botão "Começar" para a direita
                        Align(
                          alignment:
                              Alignment.centerRight, // Alinha o botão à direita
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5);
                                  }
                                  return Theme.of(context).colorScheme.primary;
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterAccount(),
                                ),
                              );
                            },
                            child: const Text(
                              'Começar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
