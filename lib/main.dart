import 'package:aranduapp/config/ThemeApp.dart';
import 'package:aranduapp/ui/welcome/view/WelcomeView.dart';
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
