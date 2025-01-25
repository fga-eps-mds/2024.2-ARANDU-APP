import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  UserModel.fromMap(Map<String, dynamic> json)
      : id = json['userId']! as String,
        name = json['name']! as String,
        email = json['email']! as String,
        role = json['role']! as String;

  factory UserModel.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return UserModel(
      id: json['userId']! as String,
      name: json['name']! as String,
      email: json['email']! as String,
      role: json['role']! as String,
    );
  }

  String toJson() {
    return jsonEncode({
      'userId': id,
      'name': name,
      'email': email,
      'role': role,
    });
  }
}

