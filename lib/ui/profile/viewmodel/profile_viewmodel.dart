import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  // Controllers e Key para o formulário
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  // Estado de carregamento
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ProfileViewModel não precisa mais do BuildContext
  ProfileViewModel();

  // Método para simular o envio do e-mail de recuperação de senha
  Future<void> forgetPassword() async {
    // Verifica se o formulário é válido
    if (!formKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);

    try {
      // Simulação de chamada de API
      await Future.delayed(const Duration(seconds: 2));

      // Validações ou chamadas reais para a API iriam aqui
      final email = emailController.text.trim();
      if (email.isEmpty) {
        throw Exception("O campo de e-mail não pode estar vazio.");
      }

      // Log fictício para simular sucesso
      debugPrint("E-mail de recuperação enviado para: $email");
    } catch (e) {
      // Relança a exceção para que o consumidor exiba o erro
      throw Exception("Erro ao enviar o e-mail: $e");
    } finally {
      _setLoading(false);
    }
  }

  // Define o estado de carregamento e notifica os ouvintes
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Destruir controllers ao finalizar a ViewModel
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
