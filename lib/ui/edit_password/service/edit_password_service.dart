import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/edit_password/model/edit_password_request.dart';

class EditPasswordService {

   Future<void> edit(EditPasswordRequest editPasswordRequest) async {
    await BaseApi.getInstance(auth: true)
        .put(path: '/auth/change-password', data: editPasswordRequest.toJson());
  }
  

}
