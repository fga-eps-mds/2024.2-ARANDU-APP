// lib/view/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:aranduapp/ui/onboarding/service/onboarding_service.dart';
import 'package:aranduapp/ui/onboarding/model/onboarding_step.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<OnboardingStep> steps = OnboardingService().getOnboardingSteps();
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
    String currentImage = steps[_currentPage].imageAsset;

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(currentImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              itemBuilder: (context, index) {
                OnboardingStep step = steps[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        step.title,
                        style: const TextStyle(
                          fontFamily: 'Amarante',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        step.description,
                        style: const TextStyle(
                          fontFamily: 'Amarante',
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 10,
            bottom: 48,
            child: FloatingActionButton(
              onPressed: _goToPreviousPage,
              mini: true,
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          if (_currentPage < steps.length - 1)
            Positioned(
              right: 10,
              bottom: 48,
              child: FloatingActionButton(
                onPressed: _goToNextPage,
                mini: true,
                backgroundColor: Colors.orange,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          Positioned(
            bottom: 50,
            right: 30, // Ajustado para posicionar mais à direita
            child: _currentPage == steps.length - 1
                ? SizedBox(
                    width: 150, // Largura reduzida
                    height: 48, // Altura reduzida
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.orange, // Cor laranja
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
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
