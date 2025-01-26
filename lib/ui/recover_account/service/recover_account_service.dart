import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/ui/recover_account/model/recover_account_request.dart';

class RecoverAccountService {
  Future<void> forgetPassword(
      RecoverAccountRequest recoverAccountRequest) async {
    await AuthApi.getInstance(auth: false)
        .post(path: '/auth/forgot-password', data: <String, dynamic>{
      'email': recoverAccountRequest.email,
    });
  }
}
