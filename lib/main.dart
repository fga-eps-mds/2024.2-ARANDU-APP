import 'package:aranduapp/config/ThemeApp.dart';
import 'package:aranduapp/ui/login/view/LoginView.dart';
import 'package:aranduapp/ui/welcome/view/WelcomeView.dart';
import 'package:aranduapp/ui/onboarding/viewModel/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/core/data/local/StorageValue.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await OnboardingViewModel().incrementNumber();

  int viewCount = await StorageValue.getInstance().getOnboardingCount() ?? 0;

  runApp(MyApp(viewCount: viewCount));
}

class MyApp extends StatelessWidget {
  final int viewCount;

  const MyApp({super.key, required this.viewCount});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.themeData(),
      darkTheme: ThemeApp.darkThemeData(),
      debugShowCheckedModeBanner: false,
      home: viewCount >= 3 ? const Login() : WelcomeView(),
    );
  }
}
