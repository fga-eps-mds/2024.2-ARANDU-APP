import 'package:flutter/material.dart';

class NavbarViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
