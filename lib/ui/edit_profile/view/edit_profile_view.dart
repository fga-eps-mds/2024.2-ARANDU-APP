import 'package:aranduapp/ui/edit_profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/text_name.dart';
import 'package:aranduapp/ui/shared/request_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Center(
            child: Text(
              'Editar perfil',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
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
          //         _deleteButton(context),
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context, EditProfileViewModel viewModel) {
    return Requestbutton(
        command: viewModel.editCommand,
        nameButton: "Salvar",
        onErrorCallback: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e)),
          );
        },
        onSuccessCallback: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario atualizado com sucesso. ')),
          );
        });
  }

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
}
