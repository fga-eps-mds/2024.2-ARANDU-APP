import 'package:async/async.dart';
import 'package:flutter/material.dart';

abstract class Command<T> extends ChangeNotifier {
  Result<T>? _result;

  bool _running = false;
  bool _hasErrorOccurred = false;

  Command();

  bool get isError => result?.asError != null && !_hasErrorOccurred;

  bool get isOk => result?.asValue != null;

  Result<T>? get result => _result;

  bool get running => _running;

  void resetError() {
    if (isError) {
      _result = null;
      notifyListeners();
    }
  }

  Future<void> _execute(Future<Result<T>> Function() action) async {
    if (running || _hasErrorOccurred) return;

    _result = null;
    _hasErrorOccurred = false;
    _running = true;
    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _result = Result.error(e);
      _hasErrorOccurred = true;
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<T> extends Command<T> {
  final Future<Result<T>> Function() action;

  Command0(this.action);

  Future<Result<T>> execute() async {
    await _execute(action);

    return result!;
  }

  @override
  void resetError() {
    super.resetError();
  }
}
