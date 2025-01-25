import 'dart:convert';

import 'package:aranduapp/core/data/local/storage_value.dart';
import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/core/network/token_manager/model/refresh_token_response.dart';
import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  Future<RefreshTokenResponse> refreshToken() async {
    String? refresh = await StorageValue.getInstance().getRefreshToken();

    assert(refresh != null);

    Response response = await AuthApi.getInstance(auth: false).post(
        path: '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refresh});

    RefreshTokenResponse tokens =
        RefreshTokenResponse.fromJsonString(response.toString());

    await StorageValue.getInstance().setAuthToken(tokens.authToken!);
    await StorageValue.getInstance().setRefreshToken(tokens.refreshToken!);

    Log.i("Tokens atualizados com sucesso.");

    return tokens;
  }

  Future<Response> validateToken() async {
    return await AuthApi.getInstance(auth: true)
        .get(path: '/auth/validate-token');
  }

  Future<UserModel> getUser() async {
    String? json = await StorageValue.getInstance().getJsonUser();

    if (json != null) {
      return UserModel.fromJsonString(json);
    } else {
      final response = await validateToken();

      Log.f(response);

      Map<String, dynamic> json = jsonDecode(response.toString());

      UserModel user = UserModel.fromMap(json['userPayload']!);

      await StorageValue.getInstance().setJsonUser(user.toJson());

      return user;
    }
  }
}
