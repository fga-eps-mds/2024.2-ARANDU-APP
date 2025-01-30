import 'dart:convert';

class AccessTrailsModel {
  final String id;
  final String title;
  final String? description;

  AccessTrailsModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory AccessTrailsModel.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    return AccessTrailsModel(
      id: json['_id'] as String? ?? "",
      title: json['title'] as String? ?? "Sem título",
      description: json['description'] as String? ?? "Sem descrição",
    );
  }
}
