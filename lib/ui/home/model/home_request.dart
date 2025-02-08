import 'dart:convert';

class HomeRequest {
  final String name;
  final String id;
  final String description;

  HomeRequest(
      {required this.name, required this.id, required this.description});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, '_id': id};
  }

  factory HomeRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return HomeRequest(
        name: json['name']! as String,
        id: json['_id']! as String,
        description: json["description"]! as String);
  }
}
