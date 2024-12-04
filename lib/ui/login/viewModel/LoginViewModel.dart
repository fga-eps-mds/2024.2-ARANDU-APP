import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:aranduapp/ui/login/service/LoginService.dart';
import 'package:aranduapp/ui/login/model/LoginRequest.dart';

import 'package:aranduapp/ui/home/view/HomeView.dart';

class LoginViewModel extends ChangeNotifier {
  final BuildContext context;

  bool isLoading;

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginViewModel(this.context)
      : isLoading = false,
        formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
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

      await LoginService.login(
          LoginRequest(emailController.text, passwordController.text));

      _moveToHome();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getRefreshTokenFuture() async {
    // TODO
    //return await LoginService.refreshToken();
    throw UnimplementedError();
  }

  Future<void> loginWithDeviceAuth() async {
    bool value = await LocalAuthentication()
        .authenticate(localizedReason: 'Toque com o dedo no sensor para logar');

    if (!value) {
      throw Exception();
    }

    _moveToHome();
  }

  void _moveToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }
}
