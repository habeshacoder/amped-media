import 'package:flutter/material.dart';

class PublisherProfileModel with ChangeNotifier {
  final int id;
  final String user_id;
  final String name;
  final String description;
  final String sex;
  final String date_of_birth;
  final String? image;
  final String? cover_image;
  final String? created_at;
  final String? updated_at;

  PublisherProfileModel({
    required this.id,
    required this.user_id,
    required this.name,
    required this.description,
    required this.sex,
    required this.date_of_birth,
    this.image = null,
    this.cover_image = null,
    this.created_at = null,
    this.updated_at = null,
  });
  factory PublisherProfileModel.fromJson(Map<String, dynamic> json) {
    return PublisherProfileModel(
      id: json['id'],
      user_id: json['user_id'],
      name: json['name'],
      description: json['description'],
      sex: json['sex'],
      date_of_birth: json['date_of_birth'],
      image: json['image'],
      cover_image: json['cover_image'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
