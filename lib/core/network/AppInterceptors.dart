import 'package:aranduapp/core/data/local/StorageValue.dart';
import 'package:aranduapp/core/log/Log.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler
  ) async {
    super.onRequest(options, handler);

    try {
      String? token = await StorageValue.getInstance().getAuthToken();

      if (token != null) {
        options.headers['Authorization'] = 'asdfasdfasdfasdfasdfasdfasdfsadfsadf';
      } else {
        Log.e('Token não encontrado');
      }
    } catch (e) {
      Log.e('Erro ao recuperar token: $e');
    }

    handler.next(options);
  }
}

