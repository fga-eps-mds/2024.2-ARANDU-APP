import 'dart:convert';

class EditProfileRequest {
  final String? email;
  final String? password;

  EditProfileRequest(this.email, this.password);

  factory EditProfileRequest.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return EditProfileRequest(
      json['email'] as String?,
      json['password'] as String?,
    );
  }
}
