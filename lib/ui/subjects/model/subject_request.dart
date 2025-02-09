import 'dart:convert';

class SubjectRequest {
  final String KnowledgeId;

  SubjectRequest({
    required this.KnowledgeId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'KnowledgeId': KnowledgeId,
    };
  }

  factory SubjectRequest.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return SubjectRequest(
      KnowledgeId: json['KnowledgeId']! as String,
    );
  }
}
