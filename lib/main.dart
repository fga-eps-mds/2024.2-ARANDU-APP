import 'package:aranduapp/config/theme_app.dart';
import 'package:aranduapp/ui/welcome/view/welcome_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.themeData(),
      darkTheme: ThemeApp.darkThemeData(),
      debugShowCheckedModeBanner: false,
      home: WelcomeView(),
    );
  }
}
