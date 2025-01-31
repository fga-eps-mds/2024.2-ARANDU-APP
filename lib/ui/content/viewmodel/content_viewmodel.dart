import 'package:flutter/material.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:aranduapp/ui/content/model/content_request.dart';
import 'package:async/async.dart';

class ContentViewModel extends ChangeNotifier {
  final ContentService _contentService = ContentService();
  final ScrollController scrollController = ScrollController();
  bool _isLoading = false;
  String? _error;
  ContentRequest? _content;
  double _progress = 0.0;

  bool get isLoading => _isLoading;
  String? get error => _error;
  ContentRequest? get content => _content;
  double get progress => _progress;
  bool get shouldShowButton => _progress == 1.0;

  late Command1<ContentRequest, String>
      contentCommand; // Corrigido: T = ContentRequest, A = String

  ContentViewModel() {
    contentCommand = Command1<ContentRequest, String>((contentId) async {
      // Corrigido
      try {
        final result = await _contentService.getContentsById(contentId);
        return result; // Retorna Result<ContentRequest>
      } catch (e) {
        return Result.error(e);
      }
    });

    scrollController.addListener(_updateProgress);
  }

  Future<void> fetchContent(String contentID) async {
    _isLoading = true;
    notifyListeners();

    final result = await contentCommand.execute(contentID);
    if (result.isValue) {
      _content = result.asValue!.value; // Agora é ContentRequest
      _error = null;
    } else if (result.isError) {
      _error = "Erro ao carregar conteúdo: ${result.asError!.error}";
      _content = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void _updateProgress() {
    if (scrollController.hasClients) {
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      _progress = (currentScroll / maxScrollExtent).clamp(0.0, 1.0);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_updateProgress);
    scrollController.dispose();
    super.dispose();
  }
}
