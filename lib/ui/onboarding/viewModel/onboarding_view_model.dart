// lib/view_model/onboarding_view_model.dart
import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int _currentStep = 0;

  // Dados do onboarding diretamente incorporados
  final List<Map<String, String>> steps = [
    {
      'title': 'Bem-vindo ao Arandu',
      'description':
          'Descubra como usar o aplicativo para maximizar sua experiência.',
      'imageAsset': 'assets/images/Component1.png',
    },
    {
      'title': 'Funcionalidades',
      'description':
          'Explore as funcionalidades únicas que tornam o Arandu especial.',
      'imageAsset': 'assets/images/Component2.png',
    },
    {
      'title': 'Comece agora',
      'description': 'Configure sua conta e comece sua jornada com o Arandu.',
      'imageAsset': 'assets/images/Component3.png',
    },
  ];

  int get currentStep => _currentStep;
  int get totalSteps => steps.length;

  void nextStep() {
    if (_currentStep < steps.length - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void completeOnboarding() {
    // Aqui você pode armazenar o estado para indicar que o onboarding foi concluído.
    // Por exemplo, usando SharedPreferences ou outro armazenamento local.
    print("Onboarding concluído!");
  }
}
