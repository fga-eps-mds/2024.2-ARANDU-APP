import 'package:flutter/material.dart';
import '../model/RegisterRequest.dart';
import '../service/RegisterService.dart';
class RegisterAccountViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  bool isLoading = false;
  bool isTermsAccepted = false; // Adicionado
  // Método para alternar a aceitação dos termos
  void toggleTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }
  Future<void> register() async {
    if (isLoading) return;
    // Valida se os termos foram aceitos
    if (!isTermsAccepted) {
      throw Exception('Você deve aceitar os termos de privacidade e políticas de uso.');
    }
    try {
      isLoading = true;
      notifyListeners();
      // Valida os campos do formulário
      if (!formKey.currentState!.validate()) {
        throw Exception('Por favor, preencha todos os campos corretamente');
      }
      // Criação do objeto de requisição
      final request = RegisterRequest(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        confPassword: confPasswordController.text,
      );
      // Chamada do serviço de registro
      await RegisterService.register(request);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}