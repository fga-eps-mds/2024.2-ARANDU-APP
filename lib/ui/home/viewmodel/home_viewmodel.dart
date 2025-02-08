import 'package:aranduapp/ui/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService = HomeService();
  List<Map<String, dynamic>> _knowledges = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get knowledges => _knowledges;
  bool get isLoading => _isLoading;
  String? get erroMessage => _errorMessage;

  Future<void> fetchKnowledges() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _homeService.getKnowledges();
    if (result != null) {
      _knowledges = result;
    } else {
      _errorMessage = "Erro ao carregar os dados";
    }

    _isLoading = false;
    notifyListeners();
  }
}
