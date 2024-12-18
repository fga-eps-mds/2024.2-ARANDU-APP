import 'package:aranduapp/ui/edit_profile/viewModel/EditProfileViewModel.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TextName.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: Colors.transparent, // Define o fundo transparente
        elevation: 0, // Remove a sombra da AppBar
        title: Center(
          child: Text(
            style: TextStyle(
              color: Colors.black, // Muda a cor do texto
              fontSize: 24, // Ajusta o tamanho (opcional)
            ),
            'Editar perfil',
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.notifications), // Ícone de notificação
            onPressed: () {
              // Ação quando o ícone de notificação for pressionado
            },
          ),
        ],
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centraliza horizontalmente
        children: [
          _icon(context),
          SizedBox(height: 50),
          _buildForm(viewModel),
        ],
      )),
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
                padding: const EdgeInsets.symmetric(vertical: 16)),
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
            SizedBox(height: 56),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _saveButton(viewModel),
                _deleteButton(context),
              ],
            ),
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
      style: ElevatedButton.styleFrom(
        minimumSize: Size(150, 50), // Largura: 200, Altura: 50
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
        minimumSize: Size(150, 50), // Largura: 200, Altura: 50
      ),
      child: const Text('Deletar Conta'),
    );
  }

  Widget _icon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0), // Adiciona espaço da borda esquerda
      child: Row(
        children: [
          // Ícone circular
          CircleAvatar(
            radius: 30, // Tamanho do círculo
          ),
          SizedBox(width: 16), // Espaço entre a imagem e o texto
          // Texto com o nome e o cargo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stefani",
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
