import 'package:flutter/material.dart';

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
        preferredSize: const Size.fromHeight(100), // Altura da AppBar
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
              padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão de voltar
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    iconSize: 24,
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey[300],
                  ),

                  // Título
                  const Text(
                    'Editar Perfil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),

                  // Ícone de notificação
                  IconButton(
                    onPressed: () {
                      // Ação para notificações
                    },
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.black),
                    iconSize: 24,
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              controller: emailController,
            ),
            const SizedBox(height: 32),

            // Botões lado a lado
            Row(
              children: [
                
                // Botão Deletar Conta
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Chamar função de deletar conta
                      _showDeleteConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 36,31), // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Deletar Conta',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Cor do texto
                      ),
                    ),
                  ),
                ),
                                const SizedBox(width: 64), // Espaçamento entre os botões
                // Botão Salvar
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica ao salvar perfil
                      print('Primeiro Nome: ${firstNameController.text}');
                      print('Último Nome: ${lastNameController.text}');
                      print('E-mail: ${emailController.text}');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 16)
                      
                      
                    ),
                  ),
                ),          
              ],
            ),
          ],
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
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para deletar a conta
                print('Conta deletada');
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Cor do botão
              ),
              child: const Text('Deletar'),
            ),
          ],
        );
      },
    );
  }
}
