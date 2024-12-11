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
          'Seja bem-vindo(a) ao Arandu! Sou um ambiente educacional voltado para aprendizado de forma gratuita.',
      'imageAsset': 'assets/images/Component1.png',
    },
    {
      'title': 'O que você vai encontrar?',
      'description':
          'Aqui você encontrará livros interativos de diversas disciplinas com objetivo de entregar praticidade e qualidade no aprendizado.',
      'imageAsset': 'assets/images/Component2.png',
    },
    {
      'title': 'Como funciona?',
      'description':
          'Para acessar uma trilha basta se inscrever na disciplina de sua preferência e ter acesso aos materiais.\n Bons estudos !',
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

  Widget _buildOnboardingImage(String imageAsset) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 530, // Altura fixa para a imagem
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1), // Duração da animação
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Container(
            key: ValueKey<String>(imageAsset), // A chave única para cada imagem
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingSteps() {
    return Positioned(
      top: 520, // Posição fixa para os textos
      left: 0,
      right: 0,
      bottom: 100, // Limita o espaço para que o botão não sobreponha
      child: PageView.builder(
        controller: _pageController,
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step['title']!,
                  style: GoogleFonts.comfortaa(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                // Envolvendo o texto com SingleChildScrollView
                SingleChildScrollView(
                  child: Text(
                    step['description']!,
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Positioned(
      bottom: 48,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão "Pular" no canto esquerdo
          if (_currentPage < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
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
            ),
          // Botão "Next Page" no canto direito
          if (_currentPage < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: FloatingActionButton(
                onPressed: _goToNextPage,
                mini: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Image.asset(
                  _currentPage == 1
                      ? 'assets/images/Buttons2.png' // Imagem para o segundo passo
                      : 'assets/images/Buttons1.png', // Imagem para os outros passos
                  width: 60,
                  height: 60,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Positioned(
      bottom: 48, // Mantido no mesmo nível do "Pular" e "Next Page"
      right: 30, // Posição fixa à direita
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterAccount(),
            ),
          );
        },
        mini: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Image.asset(
          'assets/images/Buttons3.png', // Imagem para o botão de início
          width: 60,
          height: 60,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          _buildOnboardingImage(steps[_currentPage]['imageAsset']!),
          _buildOnboardingSteps(),
          _buildNavigationButtons(),
          if (_currentPage == steps.length - 1) _buildStartButton(),
        ],
      ),
    );
  }
}
