import 'package:aranduapp/core/log/Log.dart';
import 'package:flutter/material.dart';

import 'package:aranduapp/ui/edit_profile/service/EditProfileService.dart';
import 'package:aranduapp/ui/edit_profile/model/EditProfileRequest.dart';

class EditProfileViewModel extends ChangeNotifier {
  final BuildContext context;

  bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  // Inicialização dos campos no construtor
  EditProfileViewModel(this.context)
      : isLoading = false,
        formKey = GlobalKey<FormState>(),
        firstNameController = TextEditingController(),
        lastNameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

  Future<void> editprofileWithEmailAndPassword() async {
    if (isLoading) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      if (!formKey.currentState!.validate()) {
        throw Exception('Valores inválidos');
      }

  
      await Future.delayed(const Duration(seconds: 10));


   // await EditProfileService.edit(
   //     EditProfileRequest(emailController.text, passwordController.text));

    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getRefreshTokenFuture() async {
    try {
      // Exemplo de simulação de uma operação assíncrona:
      await Future.delayed(const Duration(seconds: 2));
      // Aqui você deve chamar o serviço real que renova o token de autenticação.
      // Exemplo:
      // await LoginService.refreshToken();
    } catch (e) {
      throw Exception('Erro ao renovar o token: $e');
    }
  }
}
