import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/core/data/local/storage_value.dart';

class ProfileViewModel extends ChangeNotifier {
  late Command0<void> logoutCommand;

  ProfileViewModel() {
    logoutCommand = Command0<void>(logout);
  }

  Future<Result<void>> logout() async {
    await StorageValue.getInstance().clear();

    Log.d("Usuário deslogado com sucesso.");
    return Result.value(null);
  }
}
