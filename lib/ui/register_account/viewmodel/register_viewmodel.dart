import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../model/register_request.dart';
import '../service/register_service.dart';

class RegisterAccountViewModel extends ChangeNotifier {
  bool isTermsAccepted = false;

  late Command1<void, RegisterRequest> registerCommand;

  RegisterAccountViewModel() {
    registerCommand = Command1<void, RegisterRequest>(_register);
  }

  Future<Result<void>> _register(RegisterRequest registerRequest) async {
    if (!isTermsAccepted) {
      return Result.error(
          'Você deve aceitar os termos de privacidade e políticas de uso.');
    }

    await GetIt.instance<RegisterService>().register(registerRequest);

    return Result.value(null);
  }

  void setToggleTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }
}
