import 'dart:convert';

class TrailsModel {
  final String id;
  final String name;

  TrailsModel({
    required this.id,
    required this.name,
    
  });

  factory TrailsModel.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    return TrailsModel(
      id: json['_id']! as String,
      name: json['name']! as String, 
    );
  }
}