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
          'Seja bem vindo ao Arandu! Sou um ambiente voltado para aprendizado de forma gratuita.',
      'imageAsset': 'assets/images/Component1.1.png',
    },
    {
      'title': 'O que você encontra?',
      'description':
          'Aqui você encontrará livros interativos de diversas disciplinas com objetivo de entregar praticidade e qualidade no aprendizado.',
      'imageAsset': 'assets/images/Component2.1.png',
    },
    {
      'title': 'Como funciona?',
      'description':
          'Para acessar uma trilha basta se inscrever na disciplina de sua preferência e ter acesso aos materiais. Bons estudos!',
      'imageAsset': 'assets/images/Component3.1.png',
    },
  ];

// Vai para a próxima página do onboarding
  void _goToNextPage() {
    if (_currentPage < steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

// Volta para a página anterior do onboarding
  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

// Atualiza a página atual com base no controlador
  void _updateCurrentPage() {
    _pageController.addListener(() {
      int page = _pageController.page?.toInt() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

// Navega para a página de registro
  void _navigateToRegister() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterAccount()),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateCurrentPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

// Garante responsividade do código em qualquer tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double imageHeight = constraints.maxHeight * 0.60;
          final double contentHeight = constraints.maxHeight * 0.55;
          final double buttonHeight = constraints.maxHeight * 0.15;

          return Stack(
            children: [
              _buildSemicirclePage(context),
              _buildImageSection(imageHeight),
              _buildContentSection(contentHeight),
              _buildNavigationButtons(buttonHeight),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageSection(double height) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
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
    );
  }

  Widget _buildContentSection(double height) {
    return Positioned(
      top: height,
      left: 0,
      right: 0,
      height: height,
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
                    textStyle: Theme.of(context).textTheme.headlineMedium,
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
                        textStyle: Theme.of(context).textTheme.bodyLarge,
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
    );
  }

  Widget _buildSemicirclePage(BuildContext context) {
    return Positioned(
      top: 0,
      left: -MediaQuery.of(context).size.width * 0.3, // Desloca para a esquerda
      child: Container(
        width:
            MediaQuery.of(context).size.width * 1.3, // Largura maior que a tela
        height:
            MediaQuery.of(context).size.height * 0.4, // Altura do semicírculo
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(MediaQuery.of(context).size.height * 0.5),
            bottomRight:
                Radius.circular(MediaQuery.of(context).size.height * 0.5),
          ),
        ),
      ),
    );
  }

// Constrói todos os botões presentes no onboarding
  Widget _buildNavigationButtons(double height) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage < steps.length - 1)
              TextButton(
                onPressed: _navigateToRegister,
                child: Text(
                  'Pular',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            if (_currentPage < steps.length - 1)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _goToNextPage,
                child: Text(
                  'Avançar',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            if (_currentPage == steps.length - 1)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _navigateToRegister,
                child: Text(
                  'Começar',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
