import 'package:aranduapp/config/ThemeApp.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/ui/welcome/view/WelcomeView.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeSreen(),
        //'/nextPage': (context) => , //colocar login() ou a pagina a ser guiada 
      },
    );
  }
}
