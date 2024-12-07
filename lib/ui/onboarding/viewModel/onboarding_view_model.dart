// lib/view_model/onboarding_view_model.dart
import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int _currentStep = 0;

  // Dados do onboarding removidos

  int get currentStep => _currentStep;
  int get totalSteps => 3; // Definindo um número fixo de etapas

  void nextStep() {
    if (_currentStep < totalSteps - 1) {
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
