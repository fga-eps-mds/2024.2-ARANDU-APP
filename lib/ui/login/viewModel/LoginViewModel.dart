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
    if (isLoading) return;

    try {
      isLoading = true;
      notifyListeners();

      if (!formKey.currentState!.validate()) {
        throw Exception('Valores inválidos');
      }

      final response = await LoginService.login(
        LoginRequest(emailController.text, passwordController.text),
      );

      // Aqui estamos assumindo que a resposta tem a estrutura esperada
      var responseBody = response.data;

      var id = responseBody['id'];
      var name = responseBody['name'];
      var email = responseBody['email'];
      var accessToken = responseBody['accessToken'];
      var refreshToken = responseBody['refreshToken'];

      // Verifique se os campos necessários estão presentes
      if (id != null &&
          name != null &&
          email != null &&
          accessToken != null &&
          refreshToken != null) {
        debugPrint('Login bem-sucedido: $name');
        _moveToHome();
      } else {
        throw Exception('Resposta inesperada do servidor: Campos ausentes');
      }
    } catch (e) {
      debugPrint('Erro ao tentar logar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getRefreshTokenFuture() async {
    // TODO: Implementar a lógica de refresh token
    throw UnimplementedError();
  }

  Future<void> loginWithDeviceAuth() async {
    bool value = await LocalAuthentication()
        .authenticate(localizedReason: 'Toque com o dedo no sensor para logar');

    if (!value) throw Exception('Autenticação biométrica falhou');

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
