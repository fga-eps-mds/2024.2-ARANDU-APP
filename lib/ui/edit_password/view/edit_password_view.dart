import 'package:aranduapp/ui/edit_password/viewmodel/edit_password_viewmodel.dart';
import 'package:aranduapp/ui/shared/request_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aranduapp/ui/shared/text_password.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditPasswordViewMode(),
      child: const EditPasswordScreen(),
    );
  }
}

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({super.key});

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
    EditPasswordViewMode viewModel = Provider.of<EditPasswordViewMode>(context);

    return Form(
      key: viewModel.formKey,
      child: Column(children: [
        TextPassWord(
            label: "Senha Antiga",
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.oldPasswordController),
        TextPassWord(
            label: "Senha Nova",
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            controller: viewModel.newPasswordController),
        const SizedBox(height: 80),
        _button(context, viewModel)
      ]),
    );
  }

  Widget _button(BuildContext context, EditPasswordViewMode viewModel) {
    return Requestbutton(
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
