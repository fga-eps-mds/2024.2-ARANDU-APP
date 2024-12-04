import 'package:dio/dio.dart';
import 'package:aranduapp/ui/login/model/LoginRequest.dart';

class LoginService {
  static final _dio = Dio();

  static Future<Response> login(LoginRequest loginRequest) async {
    try {
      final response = await _dio.post(
        'http://localhost:3000/auth/login',
        data: {
          'email': loginRequest.email,
          'password': loginRequest.password,
        },
      );
      return response; // Retorna a resposta diretamente
    } catch (e) {
      throw Exception('Erro ao realizar login: $e');
    }
  }

  static Future<void> refreshToken() async {
    try {
      // Implementação do refresh token quando necessário
      throw UnimplementedError();
    } catch (e) {
      throw Exception('Erro ao renovar token: $e');
    }
  }
}
