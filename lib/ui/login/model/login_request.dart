import 'dart:convert';

class LoginRequest {

  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  factory LoginRequest.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return LoginRequest(
      json['email'] as String,
      json['password'] as String,
    );
  }

}
