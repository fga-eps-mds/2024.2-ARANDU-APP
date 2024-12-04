// lib/view_model/onboarding_view_model.dart
import 'package:flutter/material.dart';
import 'package:aranduapp/ui/onboarding/model/onboarding_step.dart';
import 'package:aranduapp/ui/onboarding/service/onboarding_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  final OnboardingService _onboardingService = OnboardingService();
  int _currentStep = 0;

  List<OnboardingStep> get steps => _onboardingService.getOnboardingSteps();
  int get currentStep => _currentStep;

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
    // Aqui você pode armazenar o estado (em preferências ou banco de dados local)
    // para indicar que o onboarding foi completado
  }
}
