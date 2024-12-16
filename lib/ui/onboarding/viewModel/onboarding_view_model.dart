import 'package:flutter/material.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void updateCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void navigateToRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterAccount()),
    );
  }
}
