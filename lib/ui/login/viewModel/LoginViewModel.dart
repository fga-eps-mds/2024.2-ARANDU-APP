import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/navbar/view/navBarView.dart';
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
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getRefreshTokenFuture() async {
    await Future.delayed(const Duration(seconds: 2));

    //await LoginService.refreshToken();
  }

  Future<bool> loginWithDeviceAuth() async {
    Log.d('init loginWithDeviceAuth');
    return await LocalAuthentication()
        .authenticate(localizedReason: 'Toque com o dedo no sensor para logar');
  }

  void goNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const NavbarView(),
      ),
    );
  }
}
