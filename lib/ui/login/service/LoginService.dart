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
        data: <String, dynamic>{
          'email': loginRequest.email,
          'password': loginRequest.password
        });

    LoginResponse loginResponse =
        LoginResponse.fromJsonString(response.toString());

    assert(
        loginResponse.authToken != null && loginResponse.refreshToken != null);

    await StorageValue.getInstance()
        .setAuthToken(loginResponse.authToken ?? '');
    await StorageValue.getInstance()
        .setRefreshToken(loginResponse.refreshToken ?? '');

    return response;
  }

  static Future<void> refreshToken() async {
    Log.d('init reresh token');

    await BaseApi.getInstance().get(path: '/auth/validate-token');

    String? refresh = await StorageValue.getInstance().getRefreshToken();

    assert(refresh != null);

    await BaseApi.getInstance().post(
        path: '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refresh});

    Log.d('finish reresh token');
  }
}
