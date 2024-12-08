import 'package:aranduapp/core/network/BaseApi.dart';
import 'package:dio/dio.dart';
import '../model/RegisterRequest.dart';

class RegisterService {

  static Future<void> register(RegisterRequest registerRequest) async {

    await BaseApi.getInstance()
        .post(path: '/asdfsdfsdf', data: <String, dynamic>{
      'name': registerRequest.name,
      'email': registerRequest.email,
      'username': registerRequest.userName,
      'passwoed': registerRequest.password,
    });

  }

}

