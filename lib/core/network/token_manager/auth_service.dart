import 'package:aranduapp/core/data/local/storage_value.dart';
import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/core/network/token_manager/model/refresh_token_response.dart';
import 'package:dio/dio.dart';

class AuthService {
  Future<RefreshTokenResponse> refreshToken() async {
    String? refresh = await StorageValue.getInstance().getRefreshToken();

    assert(refresh != null);

    Response response = await BaseApi.getInstance(auth: false).post(
        path: '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refresh});

    RefreshTokenResponse tokens =
        RefreshTokenResponse.fromJsonString(response.toString());

    await StorageValue.getInstance().setAuthToken(tokens.authToken!);
    await StorageValue.getInstance().setRefreshToken(tokens.refreshToken!);

    Log.i("Tokens atualizados com sucesso.");

    return tokens;
  }

  Future<void> validateToken() async {
    await BaseApi.getInstance(auth: true).get(path: '/auth/validate-token');
  }
}
