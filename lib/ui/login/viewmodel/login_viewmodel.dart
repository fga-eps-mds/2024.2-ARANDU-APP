import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:aranduapp/ui/login/service/login_service.dart';
import 'package:aranduapp/ui/login/model/LoginRequest.dart';

class LoginViewModel extends ChangeNotifier {

  late Command0<void> loginCommand;
  late Command0<void> validadeTokenCommand;

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginViewModel()
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController() {

    loginCommand = Command0<void>(loginWithEmailAndPassword);

    validadeTokenCommand = Command0<void>(validateToken);
    validadeTokenCommand.execute();
  }

  Future<Result<void>> loginWithEmailAndPassword() async {
    if (!formKey.currentState!.validate()) {
      return Result.error(Exception('Valores inválidos'));
    }

    await GetIt.instance<LoginService>().login(
        LoginRequest(emailController.text, passwordController.text));

    return Result.value(null);
  }

  Future<Result<void>> validateToken() async {
    await GetIt.instance<LoginService>().validateToken();

    return Result.value(null);
  }

  Future<bool> loginWithDeviceAuth() async {
    Log.d('init loginWithDeviceAuth');
    return await LocalAuthentication()
        .authenticate(localizedReason: 'Toque com o dedo no sensor para logar');
  }
}
