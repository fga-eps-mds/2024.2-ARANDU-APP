class ContentResponse {
  final String id;
  final String title;
  final String content;
  final String trail;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContentResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.trail,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContentResponse.fromJson(Map<String, dynamic> json) {
    return ContentResponse(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      trail: json['trail'],
      order: json['order'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static fromJsonString(contentJson) {}
}
