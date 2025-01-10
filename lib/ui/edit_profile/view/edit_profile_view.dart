import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/edit_profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:aranduapp/ui/shared/ErrorPopUp.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/ProfileHeader.dart';
import 'package:aranduapp/ui/shared/TextName.dart';
import 'package:aranduapp/ui/shared/requestbutton.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart'; // Certifique-se de que a biblioteca async está importada

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileViewModel(),
      child: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);

    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 50),
          _buildForm(context, viewModel),
        ],
      ),
    ));
  }

  Widget _buildForm(BuildContext context, EditProfileViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextName(
            controller: viewModel.nameController,
            padding: const EdgeInsets.symmetric(vertical: 0),
          ),
          const SizedBox(height: 20),
          TextName(
            label: "Nome de Usuário",
            controller: viewModel.userNameController,
            padding: const EdgeInsets.symmetric(vertical: 0),
          ),
          const SizedBox(height: 20),
          TextEmail(
            padding: const EdgeInsets.symmetric(vertical: 0),
            controller: viewModel.emailController,
          ),
          const SizedBox(height: 100),
          _saveButton(context, viewModel),
          const SizedBox(height: 20),
          //         _deleteButton(context), // Parte comentada mantida
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileHeader(
            name: "Stefani",
            role: "Estudante",
          ),
        ]);
  }

  Widget _saveButton(BuildContext context, EditProfileViewModel viewModel) {
    return Requestbutton(
        command: viewModel.editCommand,
        nameButton: "Salvar",
        onErrorCallback: (e) {
          if (viewModel.editCommand.isError) {
            showDialog<Object>(
              context: context,
              builder: (BuildContext dialogContext) {
                return ErrorPopUp(content: Text(e.toString()));
              },
            );
            // Resetando o erro após mostrar o pop-up para evitar a repetição
            viewModel.editCommand.resetError();
          }
        },
        onSuccessCallback: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Estamos quase lá! Confira seu e-mail para redefinir sua senha.')),
          );
        });
  }
}
  // Mantendo o código comentado conforme solicitado
  //Widget _deleteButton(BuildContext context) {
  //  return ElevatedButton(
  //    onPressed: () => _showDeleteConfirmationDialog(context),
  //    style: ElevatedButton.styleFrom(
  //      minimumSize: Size(0, 50),
  //    ),
  //    child: const Text('Deletar Conta'),
  //  );
  //}

  //void _showDeleteConfirmationDialog(BuildContext context) {
  //  showDialog(
  //    context: context,
  //    builder: (BuildContext context) {
  //      return AlertDialog(
  //        title: const Text('Confirmar Deleção'),
  //        content: const Text(
  //            'Tem certeza de que deseja deletar sua conta? Essa ação não pode ser desfeita.'),
  //        actions: [
  //          TextButton(
  //            onPressed: () {
  //              Navigator.of(context).pop();
  //            },
  //            child: const Text('Cancelar'),
  //          ),
  //          ElevatedButton(
  //            onPressed: () {
  //              Navigator.of(context).pop();
  //              ScaffoldMessenger.of(context).showSnackBar(
  //                const SnackBar(content: Text('Conta deletada com sucesso!')),
  //              );
  //            },
  //            child: const Text('Deletar'),
  //          ),
  //        ],
  //      );
  //    },
  //  );
  //}
