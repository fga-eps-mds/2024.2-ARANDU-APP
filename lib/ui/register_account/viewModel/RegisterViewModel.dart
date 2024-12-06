import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aranduapp/ui/register_account/model/RegisterRequest.dart';
import 'package:aranduapp/ui/register_account/service/RegisterService.dart';

class RegisterAccountViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  bool isLoading = false;
  bool isTermsAccepted = false;

  void toggleTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }

  Future<void> register() async {
    if (isLoading) return;

    if (!isTermsAccepted) {
      throw Exception('Você deve aceitar os termos de privacidade e políticas de uso.');
    }

    if (!formKey.currentState!.validate()) {
      throw Exception('Preencha todos os campos corretamente.');
    }

    try {
      isLoading = true;
      notifyListeners();

      final request = RegisterRequest(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
      );

      await RegisterService.register(request);

      // Salva o token no SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', 'TOKEN_EXEMPLO'); // Substituir pelo token real
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
