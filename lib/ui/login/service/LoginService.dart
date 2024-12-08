import 'package:aranduapp/core/data/local/StorageValue.dart';
import 'package:aranduapp/core/network/BaseApi.dart';
import 'package:aranduapp/ui/login/model/LoginRequest.dart';
import 'package:aranduapp/ui/login/model/LoginResponse.dart';
import 'package:dio/dio.dart';

class LoginService {

  static Future<Response> login(LoginRequest loginRequest) async {

    Response response = await BaseApi.getInstance().post(
      path: '/asdfsdfsdf',
      data: <String, dynamic> {
        'email' : loginRequest.email,
        'passwoed': loginRequest.password
      }
    );

    LoginResponse loginResponse = LoginResponse.fromJsonString(response.toString());

    await StorageValue.getInstance().setAuthToken(loginResponse.authToken);
    await StorageValue.getInstance().setAuthToken(loginResponse.authToken);


    return response;

  }

  static Future<LoginRequest> refreshToken() async {
    // TODO: implement build
    throw UnimplementedError();

  }

}


