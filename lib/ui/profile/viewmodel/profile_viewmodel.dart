import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/core/data/local/storage_value.dart';

class ProfileViewModel extends ChangeNotifier {
  // Controllers e Key para o formulário
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();


  // Estado de carregamento
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Command0<void> logoutCommand;

  ProfileViewModel() {
    logoutCommand = Command0<void>(logout);
  }

  
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

  Future<Result<void>> logout() async {
    try {
      await StorageValue.getInstance().clear();
      
      Log.d("Usuário deslogado com sucesso.");
      return Result.value(null);

    } catch (e) {
      Log.d("Erro ao realizar o logout: $e");
      return Result.error("Erro ao realizar o logout.");
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
