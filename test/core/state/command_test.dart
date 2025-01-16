import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Successful execution updates state and result', () async {
    Command0<String> command = Command0(() async {
      await Future.delayed(const Duration(seconds: 1));
      return Result.value('Success');
    });

    expect(command.running, false);
    expect(command.result, null);

    final future = command.execute();

    expect(command.running, true);
    await future;

    expect(command.running, false);
    expect(command.isOk, true);
    expect(command.result?.asValue?.value, 'Success');
  });

  test('Execution with error updates state and sets error', () async {
    Command0<String> command = Command0(() async {
      throw Exception('An error occurred');
    });

    expect(command.running, false);
    expect(command.result, null);

    final future = command.execute();

    expect(command.running, true);
    await future;

    expect(command.running, false);
    expect(command.isError, true);
    expect(command.result?.asError?.error, isA<Exception>());
  });

  test('No re-execution when already running', () async {
    //TODO: No re-execution when already running
  });

  test('Notifies listeners on state changes', () async {
    Command0<String> command = Command0(() async => Result.value('Success'));

    int notifyCount = 0;
    command.addListener(() {
      notifyCount++;
    });

    await command.execute();

    expect(notifyCount, greaterThan(0));
  });

  test('Result on second access is ok', () async {
    Command0<String> command = Command0(() async => Result.value('Success'));

    await command.execute();

    final firstAccess = command.isOk;

    final secondAccess = command.isOk;

    expect(firstAccess, true);
    expect(command.result!.asValue!.value, 'Success');
    expect(secondAccess, false);
  });

  test('Result on second access is error', () async {
    Command0<String> command = Command0(() async => Result.error('error'));

    await command.execute();

    final firstAccess = command.isError;

    final secondAccess = command.isError;

    expect(firstAccess, true);
    expect(command.result!.asError!.error, 'error');
    expect(secondAccess, false);
  });

  test('Result on second access is error with exception', () async {
    Command0<String> command = Command0(() async => throw Exception('error'));

    await command.execute();

    final firstAccess = command.isError;

    final secondAccess = command.isError;

    expect(firstAccess, true);
    expect(
        command.result?.asError?.error.toString(), equals('Exception: error'));
    expect(secondAccess, false);
  });
}
