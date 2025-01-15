import 'dart:convert';

class JourneyResponse {
  final String title;
  final String description;
  final String pointId;

  JourneyResponse(this.title, this.description, this.pointId);

  factory JourneyResponse.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return JourneyResponse(
      json['title'] as String,
      json['description'] as String,
      json['pointId'] as String
    );
  }
}
