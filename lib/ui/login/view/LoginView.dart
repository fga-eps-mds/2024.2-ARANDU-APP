import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:aranduapp/ui/login/viewModel/LoginViewModel.dart';
import 'package:aranduapp/ui/recover_account/view/RecoverAccount.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/ErrorPopUp.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';

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
  const _Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
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
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingScreen(viewModel);
          } else if (!snapshot.hasError) {
            viewModel.loginWithDeviceAuth();
            return _authDevice(viewModel);
          } else {
            return _emailAndPassword(viewModel);
          }
        },
      ),
    );
  }

  Widget _loadingScreen(LoginViewModel viewModel) {
    return const Center(
      child: CircularProgressIndicator(value: null),
    );
  }

  Widget _authDevice(LoginViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Icon(
              Icons.lock_sharp,
              color: Theme.of(context).colorScheme.primary,
              size: 120,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: 291,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                viewModel.loginWithDeviceAuth();
              },
              child: const Text('Usar senha do celular'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emailAndPassword(LoginViewModel viewModel) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: const TitleSlogan(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: _formSection(viewModel),
            ),
            _forgotPasswordLink(context),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _loginButtonSection(context, viewModel),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _createAccountLink(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DividerWithText(text: 'OU'),
            ),
            // Google logo button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GoogleLoginButton(
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formSection(LoginViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextEmail(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              controller: viewModel.emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextPassWord(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              controller: viewModel.passwordController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPasswordLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RecoverAccount(),
          ),
        );
      },
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 13, right: 20),
          child: Text(
            'Esqueceu a senha ?',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: Colors.blue,
                ),
          ),
        ),
      ),
    );
  }

  Widget _loginButtonSection(BuildContext context, LoginViewModel viewModel) {
    return SizedBox(
      width: 315,
      height: 64,
      child: ElevatedButton(
        onPressed: () {
          viewModel
              .loginWithEmailAndPassword()
              .catchError((e) => showDialog<Object>(
                    context: context,
                    builder: (BuildContext context) =>
                        ErrorPopUp(content: Text('$e')),
                  ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xfffb923c),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Consumer<LoginViewModel>(
          builder: (context, value, child) => value.isLoading
              ? const CircularProgressIndicator(value: null)
              : const Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }

  Widget _createAccountLink(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'É novo por aqui?',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RegisterAccount(),
                ),
              );
            },
            child: SizedBox(
              child: Text(
                ' Crie a sua conta',
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: Colors.blue,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para Divider com texto
class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}

// Widget para o botão do Google
class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Bordas arredondadas
          border: Border.all(color: Colors.grey), // Borda opcional
          color: Colors.transparent, // Cor de fundo para o Container
        ),
        child: Icon(
          FontAwesomeIcons.google, // Ícone do Google
          size: 20,
          color: Colors.blue, // Cor do ícone
        ),
      ),
    );
  }
}
