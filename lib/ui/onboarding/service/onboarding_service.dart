// lib/service/onboarding_service.dart

import 'package:aranduapp/ui/onboarding/model/onboarding_step.dart';

class OnboardingService {
  List<OnboardingStep> getOnboardingSteps() {
    return [
      OnboardingStep(
        title: "Lorem",
        description:
            "AranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduArandu",
        imageAsset: "assets/images/Component1.png",
      ),
      OnboardingStep(
        title: "Lorem",
        description:
            "AranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduArandu",
        imageAsset: "assets/images/Component2.png",
      ),
      OnboardingStep(
        title: "Lorem",
        description:
            "AranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduAranduArandu",
        imageAsset: "assets/images/Component3.png",
      ),
    ];
  }
}
