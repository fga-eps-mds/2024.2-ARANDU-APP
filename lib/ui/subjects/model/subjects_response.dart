import 'dart:convert';

class SubjectsResponse {
  final String title;
  final String description;

  SubjectsResponse(this.title, this.description);

  factory SubjectsResponse.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return SubjectsResponse(
      json['title'] as String,
      json['description'] as String
    );
  }
}