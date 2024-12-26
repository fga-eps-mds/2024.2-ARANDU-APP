import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/shared/OrDivider.dart';
import 'package:aranduapp/ui/shared/TextAndLink.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const TitleSlogan(),
          const SizedBox(height: 10),
          _formSection(),
          const OrDivider(),
          _buildGoogleLoginButton(),
          TextAndLink(
              text: 'Já tem uma conta?',
              link: 'faça login',
              action: () {
                Navigator.of(context).pop();
              }),
        ],
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        TextName(
            label: 'Nome de Usuário',
            controller: viewModel.userNameController,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        TextEmail(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.emailController),
        TextPassWord(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

    return ListenableBuilder(

      listenable: viewModel.registercomand,
      builder: (context, child) {
        if (viewModel.registercomand.isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog<Object>(
              context: context,
              builder: (BuildContext context) => ErrorPopUp(
                content: Text(
                    viewModel.registercomand.result!.asError!.error.toString()),
              ),
            );
          });
        }

        if (viewModel.registercomand.isOk) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'conta criada com sucesso!!!')),
            );
          });
        }

        return SizedBox(
          width: 291,
          height: 64,
          child: ElevatedButton(
            onPressed: () async {
              viewModel.registercomand.execute();
            },
            child: viewModel.registercomand.running
                ? const CircularProgressIndicator(value: null)
                : const Text('Registrar'),
          ),
        );
      },
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
