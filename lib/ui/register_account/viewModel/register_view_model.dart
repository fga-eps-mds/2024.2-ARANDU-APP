import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import '../model/register_request.dart';
import '../service/register_service.dart';

class RegisterAccountViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isTermsAccepted = false;

  late Command0<void> registerCommand;

  RegisterAccountViewModel() {
    registerCommand = Command0<void>(_register);
  }

  Future<Result<void>> _register() async {

    if (!isTermsAccepted) {
      return Result.error(
          'Você deve aceitar os termos de privacidade e políticas de uso.');
    }

    if (!formKey.currentState!.validate()) {
      return Result.error('Por favor, preencha todos os campos corretamente');
    }

    await RegisterService.register(RegisterRequest(
      email: emailController.text,
      name: nameController.text,
      userName: userNameController.text,
      password: passwordController.text,
    ));

    return Result.value(null);
  }

  void setToggleTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }
}
