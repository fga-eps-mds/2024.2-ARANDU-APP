import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/ui/join_subjects/viewmodel/join_subjects_viewmodel.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

/*class JoinSubjectsView extends StatefulWidget {
  JoinSubjects({super.key});
  
  @override
  State<JoinSubjectsView> createState() => _JoinSubjectsScreen();
}*/

class JoinSubjectsScreen extends StatelessWidget{
  //const _JoinSubjectsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildJoinSubjects(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Text('Disciplina',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        color: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Icon(
              Icons.notifications_none_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildJoinSubjects(BuildContext context){

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
        child: Container( // Aqui definimos o tamanho
          padding: EdgeInsets.only(
            left: screenWidth * 0.05, 
            right: screenWidth* 0.05,
            top: screenHeight *0.02, ), // Espaçamento à esquerda
          //height: screenHeight * 0.9,
            child: Column(
              children: [
                Row(
                  children: [ Icon(
                    Icons.book,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 120,
                  ),
                  SizedBox(width:screenWidth *0.03),
                  const Flexible(
                    child: Text(
                      'nome disciplina ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    softWrap: true,
                  )),
                  ]
                ), // Espaçamento entre o ícone e o título
                SizedBox(height: screenHeight*0.06), // Espaçamento entre o título e a descrição
                const Text(
                  'Descrição da disciplina que fornece informações relevantes sobre o conteúdo. '
                  'Este curso aborda diversos conceitos fundamentais e avançados, fornecendo uma visão detalhada sobre o tema. '
                  'Os alunos terão acesso a materiais exclusivos e participarão de atividades interativas para aprimorar seu aprendizado. '
                  'Além disso, serão discutidos estudos de caso, permitindo uma compreensão prática dos conceitos teóricos.'
                  'Descrição da disciplina que fornece informações relevantes sobre o conteúdo. '
                  'Este curso aborda diversos conceitos fundamentais e avançados, fornecendo uma visão detalhada sobre o tema. '
                  'Os alunos terão acesso a materiais exclusivos e participarão de atividades interativas para aprimorar seu aprendizado. '
                  'Além disso, serão discutidos estudos de caso, permitindo uma compreensão prática dos conceitos teóricos.'
                  'Descrição da disciplina que fornece informações relevantes sobre o conteúdo. '
                  'Este curso aborda diversos conceitos fundamentais e avançados, fornecendo uma visão detalhada sobre o tema. '
                  'Os alunos terão acesso a materiais exclusivos e participarão de atividades interativas para aprimorar seu aprendizado. '
                  'Além disso, serão discutidos estudos de caso, permitindo uma compreensão prática dos conceitos teóricos.',
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
        ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: screenHeight * 0.05), // Espaçamento inferior
        child: Center(
          child: ElevatedButton(
            onPressed: () {}, 
            child: const Text('Ingressar'),
          )
                      
        ),
      ),
    ],
  );
}