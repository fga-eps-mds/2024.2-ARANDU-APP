import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  // Estado global do aplicativo
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
