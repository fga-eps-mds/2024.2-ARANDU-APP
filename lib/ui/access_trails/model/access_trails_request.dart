import 'dart:convert';

class AccessTrailsRequest {
  final String journeyId;

  AccessTrailsRequest({required this.journeyId});

  Map<String, dynamic> toJson() => {'journeyId': journeyId};

  factory AccessTrailsRequest.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return AccessTrailsRequest(journeyId: json['journeyId']);
  }
}
