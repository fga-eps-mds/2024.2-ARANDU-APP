import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/navbar/view/navBarView.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:aranduapp/ui/login/service/LoginService.dart';
import 'package:aranduapp/ui/login/model/LoginRequest.dart';

class LoginViewModel extends ChangeNotifier {
  final BuildContext context;
  late Command0<void> loginCommand;

  bool isLoading;

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginViewModel(this.context)
      : isLoading = false,
        formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController() {
    loginCommand = Command0<void>(loginWithEmailAndPassword);
  }

  Future<Result<void>> loginWithEmailAndPassword() async {
    if (isLoading) {
      return Result.value(null);
    }

    try {
      isLoading = true;
      notifyListeners();

      if (!formKey.currentState!.validate()) {
        return Result.error(Exception('Valores inválidos'));
      }

      await LoginService.login(
          LoginRequest(emailController.text, passwordController.text));
      return Result.value(null);
    } catch (e) {
      return Result.error(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> validateToken() async {
    await LoginService.validateToken();
  }

  Future<bool> loginWithDeviceAuth() async {
    Log.d('init loginWithDeviceAuth');
    return await LocalAuthentication()
        .authenticate(localizedReason: 'Toque com o dedo no sensor para logar');
  }

  void goToHome() {
    try {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NavbarView(),
          ),
        );
      }
    } catch (e) {
      Log.e(e);
      rethrow;
    }
  }
}
