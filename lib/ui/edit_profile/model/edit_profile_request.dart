import 'dart:convert';

class EditProfileRequest {
  final String email;
  final String name;
  final String userName;

  EditProfileRequest({
    required this.email,
    required this.name,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'username': userName,
    };
  }

  factory EditProfileRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return EditProfileRequest(
      email: json['email']! as String,
      name: json['name']! as String,
      userName: json['userName']! as String,
    );
  }
}

