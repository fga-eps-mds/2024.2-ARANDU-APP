import 'dart:convert';

class SubjectsRequest {
  final String title;
  final String description;

  SubjectsRequest({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory SubjectsRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return SubjectsRequest(
      title: json['title']! as String,
      description: json['description']! as String,
    );
  }
}
