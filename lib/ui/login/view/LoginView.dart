import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/navbar/view/navBarView.dart';
import 'package:aranduapp/ui/shared/TextAndLink.dart';
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
import 'package:aranduapp/ui/shared/OrDivider.dart';

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
            }));
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
              onPressed: () async {
                viewModel.loginWithDeviceAuth().then((ok) {
                  viewModel.goNextPage();
                });
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 80),
          const TitleSlogan(),
          const SizedBox(height: 80),
          const SizedBox(height: 10),
          _formSection(viewModel),
          _forgotPasswordLink(),
          const SizedBox(height: 80),
          _loginButtonSection(),
          const OrDivider(),
          _loggingInWithOther(),
          TextAndLink(
              text: 'É novo pro aqui?',
              link: 'Cria a sua conta',
              action: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const RegisterAccount()),
                );
              }),
        ],
      ),
    );
  }

  Widget _formSection(LoginViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: <Widget>[
          TextEmail(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.emailController,
          ),
          TextPassWord(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.passwordController,
          ),
        ],
      ),
    );
  }

  Widget _forgotPasswordLink() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecoverAccount(),
          ),
        );
      },
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'esqueceu sua senha ?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ),
    );
  }

  Widget _loginButtonSection() {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return SizedBox(
      width: 291,
      height: 64,
      child: ElevatedButton(
          onPressed: () {
            viewModel.loginWithEmailAndPassword().then((_) {

              viewModel.goNextPage();

            }).catchError((e) => showDialog<Object>(
                  context: context,
                  builder: (BuildContext context) =>
                      ErrorPopUp(content: Text('$e')),
                ));
          },
          child: Consumer<LoginViewModel>(
            builder: (context, value, child) => value.isLoading
                ? const CircularProgressIndicator(value: null)
                : const Text('Entrar'),
          )),
    );
  }

  Widget _loggingInWithOther() {
    return GestureDetector(
      onTap: () => Log.d(""),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          color: Colors.transparent,
        ),
        child: Icon(
          FontAwesomeIcons.google,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
