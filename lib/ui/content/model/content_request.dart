import 'dart:convert';

class ContentRequest {
  final String title;
  final String content;
  final String trailID;

  ContentRequest({
    required this.title,
    required this.content,
    required this.trailID,
  });

  // Método seguro para conversão de JSON
  factory ContentRequest.fromJson(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return ContentRequest._fromMap(jsonMap);
    } on FormatException catch (e) {
      throw FormatException('Invalid JSON format: ${e.message}');
    }
  }

  // Método factory seguro para conversão de Map
  factory ContentRequest.fromMap(Map<String, dynamic> map) {
    try {
      return ContentRequest._fromMap(map);
    } catch (e) {
      throw ArgumentError('Invalid content data: $e');
    }
  }

  // Implementação centralizada da lógica de parsing
  factory ContentRequest._fromMap(Map<String, dynamic> map) {
    return ContentRequest(
      title: _parseString(map['title']),
      content: _parseString(map['content']),
      trailID: _parseString(map['trail']),
    );
  }

  // Método auxiliar para conversão segura de valores
  static String _parseString(dynamic value) {
    if (value == null) throw ArgumentError('Required field is missing');
    return value.toString();
  }

  // Conversão para JSON
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'trailID': trailID,
      };
}
