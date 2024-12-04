import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/config/ThemeApp.dart';
import 'package:aranduapp/ui/onboarding/view/onboarding_page.dart'; // Certifique-se de que o caminho esteja correto
import 'package:aranduapp/ui/onboarding/viewModel/onboarding_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: MaterialApp(
        theme: ThemeApp.themeData(), // Usando seu tema customizado
        debugShowCheckedModeBanner: false,
        home:
            OnboardingPage(), // Substituindo RegisterAccount por OnboardingPage
      ),
    );
  }
}
