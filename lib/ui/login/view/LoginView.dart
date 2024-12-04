import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aranduapp/ui/login/viewModel/LoginViewModel.dart';
import 'package:aranduapp/ui/recover_account/view/RecoverAccount.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context),
      child: const _Login(),
    );
  }
}

class _Login extends StatefulWidget {
  const _Login({super.key});

  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = Provider.of<LoginViewModel>(context, listen: false)
        .getRefreshTokenFuture();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingScreen();
          } else if (!snapshot.hasError) {
            return _authDevice(viewModel);
          } else {
            return _emailAndPassword(viewModel);
          }
        },
      ),
    );
  }

  Widget _loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _authDevice(LoginViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Icon(
          Icons.lock_sharp,
          color: Theme.of(context).colorScheme.primary,
          size: 120,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 291,
          height: 64,
          child: ElevatedButton(
            onPressed: viewModel.loginWithDeviceAuth,
            child: const Text('Usar senha do celular'),
          ),
        ),
      ],
    );
  }

  Widget _emailAndPassword(LoginViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const TitleSlogan(),
          const SizedBox(height: 40),
          Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                _styledTextField(
                  hint: "Email",
                  controller: viewModel.emailController,
                ),
                const SizedBox(height: 20),
                _styledTextField(
                  hint: "Senha",
                  controller: viewModel.passwordController,
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _forgotPassword(),
          const SizedBox(height: 20),
          _loginButton(viewModel),
          const SizedBox(height: 20),
          _orSeparator(),
          const SizedBox(height: 20),
          _socialIcons(),
          const SizedBox(height: 20),
          _createAccountLink(context),
        ],
      ),
    );
  }

  Widget _styledTextField({
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Container(
      width: 315,
      decoration: BoxDecoration(
        color: const Color(0xfff7f8f8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _loginButton(LoginViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        try {
          await viewModel.loginWithEmailAndPassword();
        } catch (e) {
          // Opcional: exiba uma mensagem de erro caso algo dê errado
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao fazer login: $e')),
          );
        }
      },
      child: Container(
        width: 315,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFfb923c),
              Color(0xFFc2410c),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RecoverAccount()),
          );
        },
        child: Text(
          "Esqueceu a senha?",
          style: Theme.of(context).textTheme.bodySmall!.apply(
                color: Colors.black,
              ),
        ),
      ),
    );
  }

  Widget _orSeparator() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "ou",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _socialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            print("Login com Google!");
          },
          icon: Image.asset(
            '../assets/images/google.png', // Corrigido o caminho
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: () {
            print("Login!");
          },
          icon: Image.asset(
            '../assets/images/icon.png', // Corrigido o caminho
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }

  Widget _createAccountLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Não tem uma conta?",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RegisterAccount()),
            );
          },
          child: Text(
            " Registre-se",
            style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: Colors.blue,
                  fontWeightDelta: 1,
                ),
          ),
        ),
      ],
    );
  }
}
