import 'dart:convert';

class JourneyRequest {
  final String title;
  final String description;
  final String pointId;

  JourneyRequest({
    required this.title,
    required this.description,
    required this.pointId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'pointId': pointId,
    };
  }

  factory JourneyRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return JourneyRequest(
      title: json['title']! as String,
      description: json['description']! as String,
      pointId: json['pointId']! as String,
    );
  }
}
