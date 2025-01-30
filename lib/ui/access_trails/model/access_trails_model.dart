import 'dart:convert';

class AccessTrailsModel {
  final String id;
  final String title;
  final String description;

  AccessTrailsModel({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory AccessTrailsModel.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return AccessTrailsModel(
      id: json['_id'] ?? 'Null',
      title: json['title'] ?? 'Sem título',
      description: json['description'] ?? 'Sem descrição',
    );
  }
}
