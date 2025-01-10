import 'dart:convert';
class RegisterRequest {
  final String email;
  final String name;
  final String userName;
  final String password;
  RegisterRequest({
    required this.email,
    required this.name,
    required this.userName,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': userName,
      'password': password,
    };
  }
  factory RegisterRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);
    return RegisterRequest(
      email: json['email'],
      name: json['name'],
      userName: json['userName'],
      password: json['password'],
    );
  }
}
