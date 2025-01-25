import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/app_interceptors.dart';

import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;

  static AuthApi? _authInstance, _nonAuthInstance;

  final String url = 'https://arandu-user-service.onrender.com';

  AuthApi._internal(bool auth) : _dio = Dio() {
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

  static AuthApi getInstance({required bool auth}) {
    if (auth) {
      return _authInstance ??= AuthApi._internal(auth);
    } else {
      return _nonAuthInstance ??= AuthApi._internal(auth);
    }
  }

  Future<Response> get(
      {required String path, Map<String, dynamic>? data}) async {
    try {
      return await _dio.get(path, data: data);
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

  Future<Response> patch({required String path, Object? data}) async {
    try {
      return await _dio.patch(path, data: data);
    } catch (e) {
      Log.e(e);
      rethrow;
    }
  }

  Future<Response> put({required String path, Object? data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      Log.e(e);
      rethrow;
    }
  }


  Future<Response> delete({required String path, Object? data}) async {
    try {
      return await _dio.delete(path, data: data);
    } catch (e) {
      Log.e(e);
      rethrow;
    }
  }
}
