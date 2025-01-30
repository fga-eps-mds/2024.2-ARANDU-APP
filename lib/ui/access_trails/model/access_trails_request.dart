import 'dart:convert';

class AccessTrailsRequest {
  final String journeyId;

  AccessTrailsRequest({
    required this.journeyId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'journeyId': journeyId,
    };
  }

  factory AccessTrailsRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return AccessTrailsRequest(
      journeyId: json['journeyId']! as String,
    );
  }
}
