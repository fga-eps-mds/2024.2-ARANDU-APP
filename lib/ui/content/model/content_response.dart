import 'dart:convert';

class ContentResponse {
  final String title;
  final String content;
  final String trailID;

  ContentResponse(this.title, this.content, this.trailID);
  factory ContentResponse.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    return ContentResponse(
      json['title'] as String,
      json['content'] as String,
      json['trailID'] as String,
    );
  }
}
