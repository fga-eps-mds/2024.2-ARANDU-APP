import 'dart:convert';

class HomeModel {
  final String name;
  final String id;

  HomeModel({required this.name, required this.id});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      name: json['nome'], // Ajuste conforme o campo retornado pelo backend
      id: json['id'],
    );
  }
}
