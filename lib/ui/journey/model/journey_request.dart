import 'dart:convert';

class JourneyRequest {
  final String subjectId;

  JourneyRequest({
    required this.subjectId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subjectId': subjectId,
    };
  }

  factory JourneyRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return JourneyRequest(
      subjectId: json['subjectId']! as String,
    );
  }
}
