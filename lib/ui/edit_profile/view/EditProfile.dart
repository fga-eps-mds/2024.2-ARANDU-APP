import 'package:flutter/material.dart';
import 'package:aranduapp/ui/shared/ProfileCard.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/CustomTextField.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';

class EditProfile extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Altura reduzida da AppBar
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão de voltar
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  // Título
                  const Text(
                    'Editar Perfil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Ícone de notificação
                  IconButton(
                    onPressed: () {
                      // Ação para notificações
                    },
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone abaixo da AppBar
              const SizedBox(height: 16),
              // Card com informações do perfil
              ProfileCard(
                name: 'Stefani',
                role: 'Estudante',
                avatarUrl: 'https://via.placeholder.com/150', // URL do avatar
              ),
              const SizedBox(height: 32),

              // Campo Nome usando CustomTextField
              CustomTextField(
                label: 'Primeiro Nome',
                placeholder: 'Stefani',
                controller: firstNameController,
              ),
              const SizedBox(height: 16),

              // Campo Último Nome usando CustomTextField
              CustomTextField(
                label: 'Último Nome',
                placeholder: 'Silva',
                controller: lastNameController,
              ),
              const SizedBox(height: 16),

              // Campo E-mail usando TextEmail
              TextEmail(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                controller: emailController,
              ),
              const SizedBox(height: 32),

              // Campo Password usando TextPassword
              TextPassWord(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                controller: passwordController,
              ),
              const SizedBox(height: 32),

              // Botões lado a lado
              Row(
                children: [
                  // Botão Deletar Conta
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(144, 11, 9, 1),
                              Color.fromRGBO(236, 34, 31, 1)
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Deletar Conta',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 64),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('Primeiro Nome: ${firstNameController.text}');
                        print('Último Nome: ${lastNameController.text}');
                        print('E-mail: ${emailController.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(8, 145, 178, 1),
                              Color.fromRGBO(127, 219, 229, 1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                print('Conta deletada');
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Deletar'),
            ),
          ],
        );
      },
    );
  }
}
