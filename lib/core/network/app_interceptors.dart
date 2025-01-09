import 'package:aranduapp/core/data/local/storage_value.dart';
import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/token_manager/auth_service.dart';
import 'package:aranduapp/core/network/token_manager/model/refresh_token_response.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await StorageValue.getInstance().getAuthToken();

    Log.w(token);

    if (token != null) {
      options.headers['Authorization'] = token;
    } else {
      Log.w('Token não encontrado');
    }

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        Log.i('Token expirado. Tentando atualizar o token...');

        RefreshTokenResponse tokens = await AuthService().refreshToken();

        final requestOptions = err.requestOptions;

        requestOptions.headers['Authorization'] = 'Bearer ${tokens.authToken}';

        final response = await Dio().request(
          requestOptions.path,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
          data: requestOptions.data,
        );

        Log.i('Token expirado atualizado.');
        return handler.resolve(response);
      } catch (e) {
        super.onError(err, handler);
      }
    }
  }
}
