import 'dart:convert';
class RegisterResponse {
  final String authToken;
  final String refreshToken;
  RegisterResponse({
    required this.authToken,
    required this.refreshToken,
  });
  factory RegisterResponse.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);
    return RegisterResponse(
      authToken: json['auth_token'],
      refreshToken: json['refresh_token'],
    );
  }
}