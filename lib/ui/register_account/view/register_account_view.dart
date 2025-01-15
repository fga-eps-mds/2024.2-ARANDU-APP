import 'package:aranduapp/ui/shared/or_divider.dart';
import 'package:aranduapp/ui/shared/text_and_link.dart';
import 'package:aranduapp/ui/shared/text_name.dart';
import 'package:aranduapp/ui/shared/request_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/core/log/log.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:aranduapp/ui/register_account/viewmodel/register_viewmodel.dart';

import 'package:aranduapp/ui/shared/title_slogan.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/error_popup.dart';
import 'package:aranduapp/ui/shared/text_password.dart';

class RegisterAccount extends StatelessWidget {
  const RegisterAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterAccountViewModel>.value(
      value: GetIt.instance<RegisterAccountViewModel>(),
      child: const RegisterAccountScreen(),
    );
  }
}

class RegisterAccountScreen extends StatelessWidget {
  const RegisterAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildForm(context));
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const TitleSlogan(),
          const SizedBox(height: 10),
          _formSection(context),
          const OrDivider(),
          _buildGoogleLoginButton(context),
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

  Widget _formSection(BuildContext context) {
    RegisterAccountViewModel viewModel =
        Provider.of<RegisterAccountViewModel>(context);

    return Form(
      key: viewModel.formKey,
      child: Column(children: [
        TextName(
            key: const Key('nameField'),
            label: 'Nome',
            controller: viewModel.nameController,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        TextName(
            key: const Key('userNameField'),
            label: 'Nome de Usuário',
            controller: viewModel.userNameController,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        TextEmail(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.emailController),
        TextPassWord(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.passwordController),
        _buildTermsCheckbox(context),
        const SizedBox(height: 20),
        _buildRegisterButton(context),
      ]),
    );
  }

  Widget _buildTermsCheckbox(BuildContext context) {
    final viewModel = Provider.of<RegisterAccountViewModel>(context);

    return Row(
      children: [
        Checkbox(
            value: viewModel.isTermsAccepted,
            onChanged: (value) {
              viewModel.setToggleTermsAccepted(value ?? false);
            }),
        Expanded(
          child: Text(
            'Aceite os termos de privacidade',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    final viewModel = Provider.of<RegisterAccountViewModel>(context);

    return Requestbutton(
        command: viewModel.registerCommand,
        nameButton: 'Registrar',
        onSuccessCallback: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('conta criada com sucesso!!!')),
          );
        },
        onErrorCallback: (e) {
          showDialog<Object>(
            context: context,
            builder: (BuildContext context) => ErrorPopUp(
              content: Text(
                  viewModel.registerCommand.result!.asError!.error.toString()),
            ),
          );
        });
  }

  Widget _buildGoogleLoginButton(BuildContext context) {
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
