import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/core/network/app_interceptors.dart';

import 'package:dio/dio.dart';

class BaseApi {
  final Dio _dio;

  static BaseApi? _authInstance, _nonAuthInstance;

  final String url = 'https://arandu-user-service.onrender.com';

  BaseApi._internal(bool auth) : _dio = Dio() {
    _dio.options.baseUrl = url;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);

    if (auth) _dio.interceptors.add(AppInterceptors());

    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
        request: true));
  }

  static BaseApi getInstance({required bool auth}) {
    if (auth) {
      return _authInstance ??= BaseApi._internal(auth);
    } else {
      return _nonAuthInstance ??= BaseApi._internal(auth);
    }
  }

  Future<Response> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      Log.e(e);
      rethrow;
    }
  }

  Future<Response> post({required String path, Object? data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      Log.e(e);
      rethrow;
    }
  }
}
