
class RegisterRequest {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  RegisterRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
    };
  }
}
