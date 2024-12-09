
import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/core/network/AppInterceptors.dart';
import 'package:dio/dio.dart';

class BaseApi {
  final Dio _dio;

  static BaseApi? _instance;

  BaseApi._internal()
      : _dio = Dio() {
    _dio.options.baseUrl = 'http://192.168.1.107:3000';
    _dio.options.connectTimeout = const Duration(seconds: 5); 
    _dio.options.receiveTimeout = const Duration(seconds: 5);

    _dio.interceptors.add(AppInterceptors());
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static BaseApi getInstance() {
    return _instance ??= BaseApi._internal();
  }

  Future<Response> get({required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      Log.e(e);
      rethrow;  
    }
  }

  Future<Response> post({ required String path, Object? data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      Log.e(e);
      rethrow; 
    }
  }
}
