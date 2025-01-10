import 'dart:convert';

class EditPasswordRequest {
  final String oldPassword;
  final String newPassword;

  EditPasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory EditPasswordRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return EditPasswordRequest(
      oldPassword: json['oldPpassword']! as String,
      newPassword: json['newPassword']! as String,
    );
  }
}

