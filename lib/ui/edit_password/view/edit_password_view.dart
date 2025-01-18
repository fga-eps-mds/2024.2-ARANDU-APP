import 'package:aranduapp/ui/edit_password/model/edit_password_request.dart';
import 'package:aranduapp/ui/edit_password/viewmodel/edit_password_viewmodel.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:aranduapp/ui/shared/text_password.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditPasswordViewModel>.value(
      value: GetIt.instance<EditPasswordViewModel>(),
      child: EditPasswordScreen(),
    );
  }
}

class EditPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  EditPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Center(
            child: Text(
              'Editar Senha',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
          ),
          leading: IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _buildForm(context));
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _formSection(context),
        ],
      ),
    );
  }

  Widget _formSection(BuildContext context) {
    EditPasswordViewModel viewModel =
        Provider.of<EditPasswordViewModel>(context);

    return Form(
      key: formKey,
      child: Column(children: [
        TextPassWord(
            key: const Key('old_password') ,
            label: "Senha Antiga",
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: oldPasswordController),
        TextPassWord(
            key: const Key('new_password') ,
            label: "Senha Nova",
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: newPasswordController),
        const SizedBox(height: 80),
        _button(context, viewModel)
      ]),
    );
  }

  Widget _button(BuildContext context, EditPasswordViewModel viewModel) {
    return CommandButton(
        tap: () {
          if (formKey.currentState!.validate()) {
            viewModel.editCommand.execute(EditPasswordRequest(
                oldPassword: oldPasswordController.text,
                newPassword: newPasswordController.text));
          }
        },
        command: viewModel.editCommand,
        nameButton: "Enviar",
        onErrorCallback: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e)),
          );
        },
        onSuccessCallback: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Senha atualizada com sucesso')),
          );
        });
  }
}
