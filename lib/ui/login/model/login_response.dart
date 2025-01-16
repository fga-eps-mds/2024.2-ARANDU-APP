import 'dart:convert';

class LoginResponse {

  String authToken;
  String refreshToken;

  LoginResponse(this.authToken, this.refreshToken);


  factory LoginResponse.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return LoginResponse(
      json['accessToken']! as String,
      json['refreshToken']! as String
    );
  }

}
