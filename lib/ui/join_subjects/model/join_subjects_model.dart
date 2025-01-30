import 'dart:convert';

class JoinSubjectsModel {
  final String id;
  final String title;
  final String description;


  JoinSubjectsModel({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory JoinSubjectsModel.fromJson(String jsonString) {
    final json = jsonDecode(jsonString);

    return JoinSubjectsModel(
      id: json['_id']! as String,
      title: json['title']! as String,
      description: json['description']! as String,
    );
  }
}
