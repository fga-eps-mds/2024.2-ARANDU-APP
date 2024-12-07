import 'package:flutter/material.dart';

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

}
