import 'package:aranduapp/ui/edit_delete_user/viewmode/edit_delte_user_viewmodel.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class EditDeleteUser extends StatelessWidget {
  const EditDeleteUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditDelteUserViewmodel>.value(
      value: GetIt.instance<EditDelteUserViewmodel>(),
      child: const EditDeleteUserScreen(),
    );
  }
}

class EditDeleteUserScreen extends StatelessWidget {
  const EditDeleteUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EditDelteUserViewmodel viewModel =
        Provider.of<EditDelteUserViewmodel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tem certeza de que deseja excluir sua conta? Essa ação não pode ser desfeita.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            CommandButton(
              tap: viewModel.deleteUserCommand.execute,
              command: viewModel.deleteUserCommand,
              nameButton: "Deletar",
              onSuccessCallback: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              onErrorCallback: (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Não foi possível apagar a conta')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
