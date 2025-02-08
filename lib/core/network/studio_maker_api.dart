import 'package:aranduapp/core/log/log.dart';
import 'package:dio/dio.dart';

class StudioMakerApi {
  final Dio _dio;

  static StudioMakerApi? _instance;

  final String url = 'https://arandu-studio-maker.onrender.com';

  StudioMakerApi._internal() : _dio = Dio() {
    _dio.options.baseUrl = url;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);

    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
        request: true));
  }

  static StudioMakerApi getInstance() {
    return _instance ??= StudioMakerApi._internal();
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
}
