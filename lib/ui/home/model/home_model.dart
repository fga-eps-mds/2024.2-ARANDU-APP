import 'dart:convert';

class HomeModel {
  final String name;

  HomeModel({
    required this.name,
  });
  factory HomeModel.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);

    return HomeModel(
      name: json['name']! as String,
    );
  }
}
