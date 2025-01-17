import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/recover_account/model/recover_account_request.dart';

class RecoverAccountService {
  static Future<void> forgetPassword(
      RecoverAccountRequest recoverAccountRequest) async {
    await BaseApi.getInstance(auth: false)
        .post(path: '/auth/forgot-password', data: <String, dynamic>{
      'email': recoverAccountRequest.email,
    });
  }
}
