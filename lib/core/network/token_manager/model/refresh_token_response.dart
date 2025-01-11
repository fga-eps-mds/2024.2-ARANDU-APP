import 'dart:convert';

class RefreshTokenResponse {

  String? authToken;
  String? refreshToken;

  RefreshTokenResponse(this.authToken, this.refreshToken);

  factory RefreshTokenResponse.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return RefreshTokenResponse(
      json['accessToken'] as String?,
      json['refreshToken'] as String?
    );
  }

}
