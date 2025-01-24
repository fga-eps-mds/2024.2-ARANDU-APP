import 'package:flutter/material.dart';

class ContentViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  double _progress = 0.0;

  double get progress => _progress;

  ContentViewModel() {
    scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (scrollController.hasClients) {
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      _progress = (currentScroll / maxScrollExtent).clamp(0.0, 1.0);
      notifyListeners(); // Notifica as views sobre a atualização
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_updateProgress);
    scrollController.dispose();
    super.dispose();
  }
}
