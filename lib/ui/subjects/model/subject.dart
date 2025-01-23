import 'dart:convert';

class Subject {
  final String name;
  final String shortName;
  final String description;


  Subject({
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

  factory Subject.fromJson(String jsonString) {
    final json = jsonDecode(jsonString);

    return Subject(
      name: json['name']! as String,
      shortName: json['shortName']! as String,
      description: json['description']! as String,
    );
  }
}

