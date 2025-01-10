import 'package:async/async.dart';
import 'package:flutter/material.dart';

abstract class Command<T> extends ChangeNotifier {
  Result<T>? _result;

  bool _running = false;

  Command();

  bool get isError => result?.asError != null;

  bool get isOk => result?.asValue != null;

  Result<T>? get result => _result;

  bool get running => _running;

  Future<void> _execute(action) async {
    if (running) return;

    _result = null;
    _running = true;
    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _result = Result.error(e);
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

    return _result!;
  }
}
