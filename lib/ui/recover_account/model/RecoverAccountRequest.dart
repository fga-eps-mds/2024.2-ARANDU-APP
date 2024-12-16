import 'dart:convert';

class RecoverAccountRequest {

  final String email;

  RecoverAccountRequest(this.email);

  factory RecoverAccountRequest.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return RecoverAccountRequest(
      json['email'] as String,
    );
  }

}
