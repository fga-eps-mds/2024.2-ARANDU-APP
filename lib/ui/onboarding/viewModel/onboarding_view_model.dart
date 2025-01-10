import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/core/data/local/StorageValue.dart';

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

  void navigateToNextPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  Future<void> incrementNumber() async {
    try {
      final storage = StorageValue.getInstance();
      int currentCount = await storage.getOnboardingCount() ?? 0;
      currentCount++;
      await storage.setViewOnboardingCount(currentCount);
      debugPrint('View count incremented to: $currentCount');
    } catch (e) {
      debugPrint('Error incrementing view count: $e');
    }
  }
}
