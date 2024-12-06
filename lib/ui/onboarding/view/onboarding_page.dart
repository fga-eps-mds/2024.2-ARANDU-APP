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
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          OnboardingImage(imageAsset: steps[_currentPage].imageAsset),
          OnboardingSteps(
            steps: steps,
            pageController: _pageController,
          ),
          NavigationButtons(
            currentPage: _currentPage,
            totalSteps: steps.length,
            onNext: _goToNextPage,
            onPrevious: _goToPreviousPage,
          ),
          if (_currentPage == steps.length - 1)
            StartButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterAccount(),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class OnboardingImage extends StatelessWidget {
  final String imageAsset;

  const OnboardingImage({required this.imageAsset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class OnboardingSteps extends StatelessWidget {
  final List<OnboardingStep> steps;
  final PageController pageController;

  const OnboardingSteps({
    required this.steps,
    required this.pageController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.6,
      left: 0,
      right: 0,
      bottom: 0,
      child: PageView.builder(
        controller: pageController,
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
    );
  }
}

class NavigationButtons extends StatelessWidget {
  final int currentPage;
  final int totalSteps;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const NavigationButtons({
    required this.currentPage,
    required this.totalSteps,
    required this.onNext,
    required this.onPrevious,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: onPrevious,
            mini: true,
            backgroundColor: Colors.orange,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          if (currentPage < totalSteps - 1)
            FloatingActionButton(
              onPressed: onNext,
              mini: true,
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.orange,
          ),
          onPressed: onPressed,
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
}
