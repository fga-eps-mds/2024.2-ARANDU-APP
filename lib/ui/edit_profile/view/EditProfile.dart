import 'package:flutter/material.dart';
//import 'package:aranduapp/ui/shared/ProfileCard.dart';
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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(
              255, 255, 255, 255), // Define o fundo transparente
          elevation: 0, // Remove a sombra da AppBar
          title: Center(
            child: Text(
              'Editar perfil',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications), // Ícone de notificação
              onPressed: () {
                // Ação quando o ícone de notificação for pressionado
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _icon(context),
            _nameAndLast(context),
            _emailAndPassword(context),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _deleteButton(context),
              _saveButton(context),
            ])
          ],
        ));
  }

  Widget _nameAndLast(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomTextField(
            label: ' Primeiro Nome',
            placeholder: 'Stefani',
            controller: firstNameController,
          ),

          // Campo Último Nome usando CustomTextFieldq
          CustomTextField(
            label: ' Último Nome',
            placeholder: 'Silva',
            controller: lastNameController,
          ),
        ],
      ),
    );
  }

  Widget _emailAndPassword(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextEmail(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            controller: emailController,
          ),
          TextPassWord(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            controller: passwordController,
          ),
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return SingleChildScrollView(
      child: ElevatedButton(
        onPressed: () {
          print('Primeiro Nome: ${firstNameController.text}');
          print('Último Nome: ${lastNameController.text}');
          print('E-mail: ${emailController.text}');
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(200, 50),
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
            padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }

  Widget _deleteButton(BuildContext context) {
    return SingleChildScrollView(
      child: ElevatedButton(
        onPressed: () {
          _showDeleteConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(200, 50),
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
            padding: const EdgeInsets.symmetric(vertical: 8),
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
                print('Conta deletada');
                Navigator.of(context).pop();
              },
              child: const Text('Deletar'),
            ),
          ],
        );
      },
    );
  }
}
