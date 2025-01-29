import 'dart:convert';

class AccessTrailsRequest {
  final String JourneyId;

  AccessTrailsRequest({
    required this.JourneyId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'JourneyId': JourneyId,
    };
  }

  factory AccessTrailsRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return AccessTrailsRequest(
      JourneyId: json['JourneyId']! as String,
    );
  }
}
