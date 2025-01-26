import 'package:aranduapp/core/network/auth_api.dart';

class EditDeleteUserService {
  Future<void> deleteUser(String idUser) {
    AuthApi.getInstance(auth: true).delete(path: '/users/$idUser');
    return Future.value(null);
  }
}
