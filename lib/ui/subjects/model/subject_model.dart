import 'dart:convert';

class SubjectModel {
  final String id;
  final String name;
  final String shortName;
  final String description;


  SubjectModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'shortName': shortName,
      'description': description ,
    };
  }

  factory SubjectModel.fromJson(String jsonString) {
    final json = jsonDecode(jsonString);

    return SubjectModel(
      id: json['_id']! as String,
      name: json['name']! as String,
      shortName: json['shortName']! as String,
      description: json['description']! as String,
    );
  }
}

