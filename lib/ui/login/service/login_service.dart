import 'package:aranduapp/core/data/local/storage_value.dart';
import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/core/network/token_manager/auth_service.dart';
import 'package:aranduapp/ui/login/model/login_request.dart';
import 'package:aranduapp/ui/login/model/login_response.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future<Response> login(LoginRequest loginRequest) async {
    Log.d('${loginRequest.email} ${loginRequest.password}');

    Response response = await BaseApi.getInstance(auth: false).post(
        path: '/auth/login',
        data: <String, dynamic>{
          'email': loginRequest.email,
          'password': loginRequest.password
        });

    LoginResponse loginResponse =
        LoginResponse.fromJsonString(response.toString());

    await StorageValue.getInstance().setAuthToken(loginResponse.authToken);
    await StorageValue.getInstance()
        .setRefreshToken(loginResponse.refreshToken);

    return response;
  }

  Future<void> validateToken() async {
    await AuthService().refreshToken();
  }
}
