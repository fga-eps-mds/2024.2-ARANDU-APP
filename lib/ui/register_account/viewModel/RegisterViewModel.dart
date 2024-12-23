import 'package:aranduapp/ui/shared/ErrorPopUp.dart';
import 'package:flutter/material.dart';
import '../model/RegisterRequest.dart';
import '../service/RegisterService.dart';

class RegisterAccountViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confPasswordController = TextEditingController();

  bool isLoading = false;
  bool isTermsAccepted = false;

  void toggleTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (isLoading) return;
    // Valida se os termos foram aceitos
    if (!isTermsAccepted) {
      throw Exception(
          'Você deve aceitar os termos de privacidade e políticas de uso.');
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
        name: nameController.text,
        userName: userNameController.text,
        password: passwordController.text,
      );
      // Chamada do serviço de registro
      await RegisterService.register(request);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cadastro concluído com sucesso!")));
    } catch (e) {
      showDialog<Object>(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(content: Text('$e')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
