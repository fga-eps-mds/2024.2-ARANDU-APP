import 'package:aranduapp/ui/recover_account/viewmodel/recover_account_viewmodel.dart';
import 'package:aranduapp/ui/shared/error_popup.dart';
import 'package:aranduapp/ui/shared/text_and_link.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/title_slogan.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class RecoverAccount extends StatelessWidget {
  const RecoverAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecoverAccountViewModel>.value(
      value: GetIt.instance<RecoverAccountViewModel>(),
      child: const RecoverAccountScreen(),
    );
  }
}

class RecoverAccountScreen extends StatelessWidget {
  const RecoverAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecoverAccountViewModel viewModel =
        Provider.of<RecoverAccountViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              const TitleSlogan(),
              const Padding(
                padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Text(
                  'Coloque o seu e-mail no campo abaixo e clique em enviar. Logo em seguida, você receberá no seu e-mail as instruções para trocar a sua senha.',
                ),
              ),
              Form(
                  key: viewModel.formKey,
                  child: Column(children: <Widget>[
                    TextEmail(
                        padding:
                            const EdgeInsets.only(top: 24, left: 20, right: 20),
                        controller: viewModel.emailController),
                  ])),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: CommandButton(
                    tap: viewModel.recoverCommand.execute ,
                    command: viewModel.recoverCommand,
                    onErrorCallback: (String e) {
                      showDialog<Object>(
                        context: context,
                        builder: (BuildContext context) =>
                            ErrorPopUp(content: Text(e)),
                      );
                    },
                    onSuccessCallback: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Estamos quase lá! Confira seu e-mail para redefinir sua senha.')),
                      );
                    },
                    nameButton: 'Enviar'),
              ),
              TextAndLink(
                text: 'Já tem uma conta?',
                link: 'Faça login',
                action: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
