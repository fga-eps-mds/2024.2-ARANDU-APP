import 'package:aranduapp/core/data/local/StorageValue.dart';
import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/core/network/BaseApi.dart';
import 'package:aranduapp/ui/login/model/LoginRequest.dart';
import 'package:aranduapp/ui/login/model/LoginResponse.dart';
import 'package:dio/dio.dart';

class LoginService {

  static Future<Response> login(LoginRequest loginRequest) async {

    Log.d('${loginRequest.email} ${loginRequest.password}');

    Response response = await BaseApi.getInstance().post(
      path: '/auth/login',
      data: <String, dynamic> {
        'email' : loginRequest.email,
        'password': loginRequest.password
      }
    );

    LoginResponse loginResponse = LoginResponse.fromJsonString(response.toString());

    assert(loginResponse.authToken != null && loginResponse.refreshToken != null);

    await StorageValue.getInstance().setAuthToken(loginResponse.authToken ?? '');
    await StorageValue.getInstance().setAuthToken(loginResponse.refreshToken??'');


    return response;

  }

  static Future<LoginRequest> refreshToken() async {
    // TODO: implement build
    throw UnimplementedError();

  }

}


