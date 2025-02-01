import 'package:aranduapp/core/log/log.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

abstract class Command<T> extends ChangeNotifier {
  Result<T>? _result;

  bool _running = false;
  bool _isError = false;
  bool _isOk = false;

  Command();

  bool get isError {
    bool tmp = _isError;
    _isError = false;
    return tmp;
  }

  bool get isOk {
    bool tmp = _isOk;
    _isOk = false;
    return tmp;
  }

  Result<T>? get result => _result;

  bool get running => _running;

  Future<void> _execute(action) async {
    if (running) return;

    _result = null;
    _running = true;
    _isOk = false;
    _isError = false;
    notifyListeners();

    try {
      _result = await action();

      if (_result?.asError != null) {
        _isError = true;
        Log.e(_result?.asError!.error.toString());
      } else {
        _isOk = true;
      }

    } catch (e) {
      Log.e(e);
      _result = Result.error(e);
      _isError = true;
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

class Command1<T, A> extends Command<T> {
  final Future<Result<T>> Function(A) action;

  Command1(this.action);

  Future<Result<T>> execute(A arg1) async {
    await _execute(() => action(arg1));
    return result!;
  }
}

class Command2<T, A, B> extends Command<T> {
  final Future<Result<T>> Function(A, B) action;

  Command2(this.action);

  Future<Result<T>> execute(A arg1, B arg2) async {
    await _execute(() => action(arg1, arg2));
    return result!;
  }
}
