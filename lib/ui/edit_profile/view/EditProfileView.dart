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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Editar perfil',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _icon(context),
                  SizedBox(height: isSmallScreen ? 30 : 50),
                  _buildForm(viewModel, isSmallScreen),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(EditProfileViewModel viewModel, bool isSmallScreen) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextName(
            controller: viewModel.firstNameController,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          SizedBox(height: 20),
          TextEmail(
            padding: const EdgeInsets.symmetric(vertical: 16),
            controller: viewModel.emailController,
          ),
          SizedBox(height: 20),
          TextPassWord(
            padding: const EdgeInsets.symmetric(vertical: 16),
            controller: viewModel.passwordController,
          ),
          SizedBox(height: isSmallScreen ? 40 : 56),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _saveButton(viewModel),
              ),
              SizedBox(width: isSmallScreen ? 10 : 20),
              Expanded(
                child: _deleteButton(context),
              ),
            ],
          ),
        ],
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
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
      ),
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
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
      ),
      child: const Text('Deletar Conta'),
    );
  }

  Widget _icon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NOME",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Estudante",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
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
