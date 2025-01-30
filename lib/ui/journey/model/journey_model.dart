import 'dart:convert';

class JourneyModel {
  final String id;
  final String title;
  final String? description;

  JourneyModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory JourneyModel.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    return JourneyModel(
      id: json['_id']! as String,
      title: json['title']! as String,
      description: json['description'] as String,
    );
  }
}
