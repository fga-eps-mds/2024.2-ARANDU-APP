import 'package:aranduapp/ui/login/view/LoginView.dart';
import 'package:aranduapp/ui/shared/OrDivider.dart';
import 'package:aranduapp/ui/shared/PhraseLink.dart';
import 'package:aranduapp/ui/shared/TextName.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/core/log/Log.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:aranduapp/ui/register_account/viewModel/RegisterViewModel.dart';

import 'package:aranduapp/ui/shared/TitleSlogan.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/ErrorPopUp.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';

class RegisterAccount extends StatelessWidget {
  const RegisterAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterAccountViewModel(),
      child: const _RegisterAccount(),
    );
  }
}

class _RegisterAccount extends StatefulWidget {
  const _RegisterAccount({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterAccountState();
  }
}

class _RegisterAccountState extends State<_RegisterAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildForm());
  }

  Widget _buildForm() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitleSlogan(),
                const SizedBox(height: 30),
                _formSection(),
                const OrDivider(),
                _buildGoogleLoginButton(),
                const SizedBox(height: 20),
                const TextAndLink(
                    text: 'Já tem uma conta?', link: 'faça login', page: Login()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formSection() {
    RegisterAccountViewModel viewModel =
        Provider.of<RegisterAccountViewModel>(context);

    return Form(
      key: viewModel.formKey,
      child: Column(children: [
        TextName(
            label: 'Nome',
            controller: viewModel.nameController,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        TextName(
            label: 'Nome de Usuário',
            controller: viewModel.userNameController,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        TextEmail(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            controller: viewModel.emailController),
        TextPassWord(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            controller: viewModel.passwordController),
        _buildTermsCheckbox(),
        const SizedBox(height: 20),
        _buildRegisterButton(),
      ]),
    );
  }

  Widget _buildTermsCheckbox() {
    final viewModel = Provider.of<RegisterAccountViewModel>(context);
    return Row(
      children: [
        Checkbox(
          value: viewModel.isTermsAccepted,
          onChanged: (value) {
            // Ação ao clicar no checkbox
            if (value != null) {
              viewModel.toggleTermsAccepted(value);
            }
          },
        ),
        Expanded(
          child: Text(
            'Aceite os termos de privacidade',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    final viewModel = Provider.of<RegisterAccountViewModel>(context);
    return SizedBox(
      width: 291,
      height: 64,
      child: ElevatedButton(
          onPressed: () {
            viewModel.register().catchError((e) => showDialog<Object>(
                  context: context,
                  builder: (BuildContext context) =>
                      ErrorPopUp(content: Text('$e')),
                ));
            // Ação ao clicar no botão de cadastro
          },
          child: Consumer<RegisterAccountViewModel>(
            builder: (context, value, child) => value.isLoading
                ? const CircularProgressIndicator(value: null)
                : const Text('Registrar'),
          )),
    );
  }


  Widget _buildGoogleLoginButton() {
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

