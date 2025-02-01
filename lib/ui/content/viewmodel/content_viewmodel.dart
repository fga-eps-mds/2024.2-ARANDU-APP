import 'package:flutter/material.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:aranduapp/ui/content/model/content_request.dart';
// ignore: unused_import
import 'package:async/async.dart';

class ContentViewModel extends ChangeNotifier {
  final ContentService _contentService = ContentService();
  final ScrollController scrollController = ScrollController();
  ContentRequest? _content;
  double _progress = 0.0;

  ContentRequest? get content => _content;
  double get progress => _progress;
  bool get shouldShowButton => _progress == 1.0;

  late Command1<ContentRequest, String> contentCommand;

  ContentViewModel() {
    contentCommand = Command1<ContentRequest, String>((contentId) async {
      final result = await _contentService.getContentsById(contentId);
      return result;
    });

    contentCommand.addListener(() {
      if (contentCommand.isError) {
        _content = null;
      } else if (contentCommand.isOk) {
        _content = contentCommand.result?.asValue?.value;
      }
      notifyListeners();
    });

    scrollController.addListener(_updateProgress);
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
    contentCommand.dispose(); // Dispose do Command
    super.dispose();
  }
}
