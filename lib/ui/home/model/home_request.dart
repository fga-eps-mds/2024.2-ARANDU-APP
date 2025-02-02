import 'dart:convert';

class HomeRequest {
  final String name;

  HomeRequest({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory HomeRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return HomeRequest(
      name: json['name']! as String,
    );
  }
}
