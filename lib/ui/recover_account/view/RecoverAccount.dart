import 'package:aranduapp/ui/recover_account/viewModel/recoverAccountViewModel.dart';
import 'package:aranduapp/ui/shared/TextAndLink.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoverAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => RecoverAccountViewModel(context),
      child: page(context),
    ));
  }

  Widget page(BuildContext context) {
    RecoverAccountViewModel viewModel =
        Provider.of<RecoverAccountViewModel>(context);

    return SingleChildScrollView(
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
                    onPressed: () {}, child: const Text('Enviar')),
              ),
            ),
            TextAndLink(
              text: 'Já tem uma conta?',
              link: ' Click aqui',
              action: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
