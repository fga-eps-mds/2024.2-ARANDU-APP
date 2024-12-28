import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/recover_account/model/RecoverAccountRequest.dart';
import 'package:aranduapp/ui/recover_account/service/RecoverAccountService.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class RecoverAccountViewModel extends ChangeNotifier {
  GlobalKey<FormState> formKey;

  TextEditingController emailController;

  late Command0<void> recoverCommand;

  RecoverAccountViewModel()
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController() {
    recoverCommand = Command0(_forgetPassword);
  }

  Future<Result<void>> _forgetPassword() async {
    if (!formKey.currentState!.validate()) {
      Result.error('Valores inválidos');
    }

    await RecoverAccountService.forgetPassword(
        RecoverAccountRequest(emailController.text));

    return Result.value(null);
  }
}
