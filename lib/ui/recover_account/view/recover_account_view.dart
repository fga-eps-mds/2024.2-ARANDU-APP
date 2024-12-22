import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/recover_account/viewModel/recover_account_view_model.dart';
import 'package:aranduapp/ui/shared/ErrorPopUp.dart';
import 'package:aranduapp/ui/shared/TextAndLink.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoverAccount extends StatelessWidget {
  const RecoverAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RecoverAccountViewModel(),
        builder: (context, child) {
          return const RecoverAccountScreen();
        });
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
                child: SizedBox(
                  width: 291,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.forgetPassword().then((value) {
                        Log.d("Deu certo!");
                      }).catchError((e) => showDialog<Object>(
                            context: context,
                            builder: (BuildContext context) =>
                                ErrorPopUp(content: Text('$e')),
                          ));
                    },
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator(value: null)
                        : const Text('Enviar'),
                  ),
                ),
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
