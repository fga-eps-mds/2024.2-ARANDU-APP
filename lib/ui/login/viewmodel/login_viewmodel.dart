import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:aranduapp/ui/login/service/login_service.dart';
import 'package:aranduapp/ui/login/model/login_request.dart';

class LoginViewModel extends ChangeNotifier {
  late Command1<void, LoginRequest> loginCommand;
  late Command0<void> validadeTokenCommand;

  LoginViewModel() {
    loginCommand = Command1<void, LoginRequest>(loginWithEmailAndPassword);

    validadeTokenCommand = Command0<void>(validateToken);
    validadeTokenCommand.execute();
  }

  Future<Result<void>> loginWithEmailAndPassword(
      LoginRequest loginRequest) async {
    await GetIt.instance<LoginService>().login(loginRequest);

    return Result.value(null);
  }

  Future<Result<void>> validateToken() async {
    await GetIt.instance<LoginService>().validateToken();

    return Result.value(null);
  }

  Future<bool> loginWithDeviceAuth() async {
    Log.d('init loginWithDeviceAuth');
    var auth = GetIt.instance<LocalAuthentication>();

    if (await auth.canCheckBiometrics && await auth.isDeviceSupported()) {
      return auth.authenticate(
          localizedReason: 'Toque com o dedo no sensor para logar');
    } else {
      Log.d('Device authentication not available, returning true');
      return true;
    }
  }
}
