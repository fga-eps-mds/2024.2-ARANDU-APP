import 'dart:convert';

class TrailsRequest {
  final String journeyId;

  TrailsRequest({
    required this.journeyId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'journeyId': journeyId,
    };
  }

  factory TrailsRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return TrailsRequest(
      journeyId: json['journeyId']! as String,
    );
  }
}
