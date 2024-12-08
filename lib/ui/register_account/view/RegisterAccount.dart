import 'package:aranduapp/ui/login/view/LoginView.dart';
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
    RegisterAccountViewModel viewModel = Provider.of<RegisterAccountViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          // Cabeçalho com padrão de losangos
          _buildHeader(viewModel),
          // Corpo do formulário
          _buildForm(viewModel),
        ],
      ),
    );
  }

  Widget _buildHeader(RegisterAccountViewModel viewModel) {
    return const Stack(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: TitleSlogan(),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildForm(RegisterAccountViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Olá,\nCrie uma conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextName(label : 'Nome', controller: viewModel.nameController, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
              TextName(label : 'Nome de Usuário', controller: viewModel.userNameController, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
              TextEmail(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0), controller: viewModel.emailController),
              TextPassWord(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0), controller: viewModel.passwordController),
              const SizedBox(height: 10),
              _buildTermsCheckbox(context),
              const SizedBox(height: 20),
              _buildRegisterButton(context, viewModel),
              const SizedBox(height: 20),
              _buildDividerWithText(),
              const SizedBox(height: 20),
              _buildGoogleLoginButton(),
              const SizedBox(height: 20),
              _buildLoginRedirectButton(context),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTermsCheckbox(BuildContext context) {
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
        const Expanded(
          child: Text(
            'Para continuar, aceite os termos de privacidade e políticas de uso',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context, RegisterAccountViewModel viewModel) {
    return SizedBox(
      width: 291,
      height: 64,
      child: ElevatedButton(
        onPressed: () {
          viewModel
            .register()
            .catchError((e) => showDialog<Object>(
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

  Widget _buildDividerWithText() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('ou'),
        ),
        Expanded(child: Divider()),
      ],
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


  Widget _buildLoginRedirectButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navegar para a tela de login
        Navigator.of(context).push(
          MaterialPageRoute(
                  builder: (context) => const Login(),
          ),
        );
      },
      child: const Text(
        'Já tem uma conta? faça login',
      ),
    );
  }
}
