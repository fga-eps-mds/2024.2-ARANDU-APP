import 'dart:convert';

class RegisterRequest {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String confPassword;

  RegisterRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'confPassword': confPassword,
    };
  }

  factory RegisterRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);
    return RegisterRequest(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      confPassword: json['confPassword'],
    );
  }
}
