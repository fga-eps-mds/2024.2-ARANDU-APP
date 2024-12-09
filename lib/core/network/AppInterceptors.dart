import 'package:aranduapp/core/data/local/StorageValue.dart';
import 'package:aranduapp/core/log/Log.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
      super.onRequest(options, handler);

      try {
        
        String? token = await StorageValue.getInstance().getAuthToken();

        if ( token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          Log.e(token);
        }

        handler.next(options);


      } catch (e) {
        Log.e(e);
      }
    } 
}
