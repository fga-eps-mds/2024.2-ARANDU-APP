import 'package:aranduapp/ui/shared/TextName.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aranduapp/ui/edit_profile/viewModel/EditProfileViewModel.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileViewModel(context),
      child: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: _buildForm(viewModel)
    );
  }

  Widget _buildForm(EditProfileViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextName(
              controller: viewModel.firstNameController,
              padding: const EdgeInsets.symmetric(vertical: 16)
            ),

            TextEmail(
              padding: const EdgeInsets.symmetric(vertical: 16),
              controller: viewModel.emailController,
            ),

            TextPassWord(
              padding: const EdgeInsets.symmetric(vertical: 16),
              controller: viewModel.passwordController,
            ),

            const SizedBox(height: 32),
            _saveButton(viewModel),
            const SizedBox(height: 16),
            _deleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget _saveButton(EditProfileViewModel viewModel) {
    return ElevatedButton(
      onPressed: () async {
        if (viewModel.isLoading) return;
        try {
          await viewModel.editprofileWithEmailAndPassword();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil atualizado com sucesso!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: $e')),
          );
        }
      },

      child: Consumer<EditProfileViewModel>(
        builder: (context, value, child) => value.isLoading
            ? const CircularProgressIndicator(value: null)
            : const Text('Salvar'),
      ),

    );
  }

  Widget _deleteButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showDeleteConfirmationDialog(context),
      child: const Text('Deletar Conta'),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Deleção'),
          content: const Text(
              'Tem certeza de que deseja deletar sua conta? Essa ação não pode ser desfeita.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Conta deletada com sucesso!')),
                );
              },
              child: const Text('Deletar'),
            ),
          ],
        );
      },
    );
  }
}
