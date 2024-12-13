import 'package:aranduapp/core/network/BaseApi.dart';
import 'package:aranduapp/ui/recover_account/model/RecoverAccountRequest.dart';

class RecoverAccountService {


  static Future<void> forgetPassword(RecoverAccountRequest  recoverAccountRequest) async {

    await BaseApi.getInstance().post(
      path: '/auth/forgot-password',
      data: <String, dynamic> {
        'email' : recoverAccountRequest.email,
      }
    );
  }

}
