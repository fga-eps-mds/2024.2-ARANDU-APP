
import 'package:flutter/material.dart';
//import 'package:local_auth/local_auth.dart';
import 'package:aranduapp/ui/welcome/model/WelcomeModel.dart';

//import 'package:aranduapp/ui/home/view/HomeView.dart';

class WelcomeViewModel {

  final WelcomeModel _model = WelcomeModel("Arandú", "Começar");
  
  String get title => _model.title;
  String get buttonText => _model.buttonText;

  void navigateToNextPage(BuildContext context) {
    Navigator.pushNamed(context, '/nextPage');
  }
}

