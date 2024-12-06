import 'package:dio/dio.dart';
import 'package:aranduapp/ui/register_account/model/RegisterRequest.dart';

class RegisterService {
  static final Dio _dio = Dio();

  static Future<void> register(RegisterRequest request) async {
    final response = await _dio.post(
      'https://example.com/register',
      data: request.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao criar conta: ${response.data['message']}');
    }
  }
}
