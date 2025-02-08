import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/home/service/home_service.dart';
import 'package:async/async.dart'; // Certifique-se de importar o pacote que contém o tipo Result
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  List<Map<String, dynamic>> knowledges = [];
  String? erroMessage;

  late Command1<List<Map<String, dynamic>>, Null> fetchKnowledgesCommand;

  HomeViewModel() {
    fetchKnowledgesCommand =
        Command1<List<Map<String, dynamic>>, Null>((_) async {
      final knowledges = await _homeService.getKnowledges();
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
