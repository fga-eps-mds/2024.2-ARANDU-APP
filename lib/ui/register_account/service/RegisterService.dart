import 'package:aranduapp/core/network/base_api.dart';
import '../model/RegisterRequest.dart';

class RegisterService {
  static Future<void> register(RegisterRequest registerRequest) async {
    await BaseApi.getInstance(auth: false)
        .post(path: '/users', data: <String, dynamic>{
      'name': registerRequest.name,
      'email': registerRequest.email,
      'username': registerRequest.userName,
      'password': registerRequest.password,
    });
  }
}
