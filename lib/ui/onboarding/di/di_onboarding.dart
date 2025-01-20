import 'package:aranduapp/ui/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupOnboardingDI() {
  GetIt.I.registerFactory(() => OnboardingViewModel());
}
