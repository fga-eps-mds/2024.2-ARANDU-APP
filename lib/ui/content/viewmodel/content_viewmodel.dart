import 'package:aranduapp/ui/content/model/content_request.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';

class ContentViewModel extends ChangeNotifier {
  final ContentService _contentService = ContentService();
  final ScrollController scrollController = ScrollController();
  ContentRequest? _content;
  double _progress = 0.0;
  int _wordCount = 0;

  ContentRequest? get content => _content;
  double get progress => _progress;
  bool get shouldShowButton => _progress == 1.0;
  int get wordCount => _wordCount;

  String get estimatedReadingTime {
    if (_wordCount == 0) return "Calculando tempo de leitura...";
    const wordsPerMinute = 200; // Média de palavras lidas por minuto
    final minutes = (_wordCount / wordsPerMinute).ceil();
    return "Tempo estimado de leitura: $minutes min.";
  }

  late Command1<ContentRequest, String> contentCommand;

  ContentViewModel() {
    contentCommand = Command1<ContentRequest, String>((contentId) async {
      final result = await _contentService.getContentsById(contentId);
      return result;
    });

    contentCommand.addListener(() {
      if (contentCommand.isError) {
        _content = null;
        _wordCount = 0;
      } else if (contentCommand.isOk) {
        _content = contentCommand.result?.asValue?.value;
        _wordCount = _countWords(_content?.content ?? "");
      }
      notifyListeners();
    });

    scrollController.addListener(_updateProgress);
  }

  // Método para contar palavras no conteúdo
  int _countWords(String text) {
    if (text.isEmpty) return 0;
    return text.split(RegExp(r'\s+')).length;
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
    contentCommand.dispose();
    super.dispose();
  }
}
