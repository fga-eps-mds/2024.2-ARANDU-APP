import 'package:aranduapp/ui/home/service/home_service.dart';
import 'package:flutter/material.dart';

class subjectsByKnowledgesView extends StatelessWidget {
  final String knowledgeId;
  final String subjectName;

  const subjectsByKnowledgesView(
      {super.key, required this.knowledgeId, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final homeService = HomeService();

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
          future: homeService.getSubjectsByKnowledges(knowledgeId, subjectName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro: ${snapshot.error}'),
              );
            }
            final subjects = snapshot.data;
            if (subjects == null || subjects.isEmpty) {
              return const Center(
                child: Text('Nenhum conteúdo disponivel'),
              );
            }
            return ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return ListTile(
                  leading: const Icon(Icons.subject),
                  title: Text(subject['name']?.toString() ?? ""),
                  subtitle: Text(subject['description']?.toString() ?? ""),
                );
              },
            );
          }),
    );
  }
}
