import 'dart:convert';

class KnowledgeRequest {
  final String name;
  final String id;
  final String description;

  KnowledgeRequest(
      {required this.name, required this.id, required this.description});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, '_id': id};
  }

  factory KnowledgeRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return KnowledgeRequest(
        name: json['name']! as String,
        id: json['_id']! as String,
        description: json["description"]! as String);
  }
}
