import 'dart:convert';

class ContentRequest {
  final String title;
  final String content;
  final String trailID;

  ContentRequest(
      {required this.title, required this.content, required this.trailID});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'trailID': trailID,
    };
  }

  factory ContentRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return ContentRequest(
      title: json['title']! as String,
      content: json['content'] as String,
      trailID: json['trailID'] as String,
    );
  }
}
