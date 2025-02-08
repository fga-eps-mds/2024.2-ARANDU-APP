import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/knowledge/service/knowledge_service.dart';
import 'package:async/async.dart'; // Certifique-se de importar o pacote que contém o tipo Result
import 'package:flutter/material.dart';

class KnowledgeViewmodel extends ChangeNotifier {
  final KnowledgeService _knowledgeService = KnowledgeService();

  List<Map<String, dynamic>> knowledges = [];
  String? erroMessage;

  late Command1<List<Map<String, dynamic>>, Null> fetchKnowledgesCommand;

  KnowledgeViewmodel() {
    fetchKnowledgesCommand =
        Command1<List<Map<String, dynamic>>, Null>((_) async {
      final knowledges = await _knowledgeService.getKnowledges();
      if (knowledges != null) {
        return Result.value(knowledges);
      } else {
        return Result.error("Erro ao carregar áreas de conhecimento");
      }
    });

    fetchKnowledgesCommand.addListener(() {
      if (fetchKnowledgesCommand.isError) {
        erroMessage = "Erro ao carregar os dados";
      } else if (fetchKnowledgesCommand.isOk) {
        knowledges = fetchKnowledgesCommand.result?.asValue?.value ?? [];
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    fetchKnowledgesCommand.dispose();
    super.dispose();
  }
}
