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
    // TODO use mutex to make this
    if (isLoading) {
      return;
    }

    try {
      isLoading = true;
      super.notifyListeners();

      if (!formKey.currentState!.validate()) {
        throw Exception('Valores inválidos');
      }

      await EditProfileService.edit(
          EditProfileRequest(emailController.text, passwordController.text));
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }

    Future<void> getRefreshTokenFuture() async {
      // TODO
      //return await LoginService.refreshToken();
      throw UnimplementedError();
    }
  }
}
