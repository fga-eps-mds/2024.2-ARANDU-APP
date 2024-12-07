// lib/view/onboarding_page.dart
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
      'title': 'Lorem',
      'description':
          'AranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduArandu',
      'imageAsset': 'assets/images/Component1.png',
    },
    {
      'title': 'Lorem',
      'description':
          'AranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduArandu',
      'imageAsset': 'assets/images/Component2.png',
    },
    {
      'title': 'Lorem',
      'description':
          'AranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduArandu',
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
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingSteps() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.6,
      left: 0,
      right: 0,
      bottom: 0,
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
                Text(
                  step['description']!,
                  style: GoogleFonts.comfortaa(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
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
        mainAxisAlignment: MainAxisAlignment.end, // Alinha os botões à direita
        children: [
          // Botão de voltar (aparece apenas se não estiver na primeira página)
          if (_currentPage > 0)
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: FloatingActionButton(
                onPressed: _goToPreviousPage,
                mini: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          SizedBox(width: 10),
          // Botão de avançar (sempre à direita)
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: FloatingActionButton(
              onPressed: _goToNextPage,
              mini: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Positioned(
      bottom: 50,
      right: 30,
      child: SizedBox(
        width: 150,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
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
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
