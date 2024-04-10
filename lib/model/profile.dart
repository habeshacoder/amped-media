// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ProfileModel with ChangeNotifier {
  int? id;
  String? user_id;
  String? first_name;
  String? last_name;
  String? sex;
  String? date_of_birth;
  String? profile_image;
  String? password;
  String? cover_image;
  String? created_at;
  String? updated_at;

  ProfileModel({
    required this.id,
    required this.user_id,
    required this.first_name,
    required this.password,
    required this.last_name,
    required this.sex,
    required this.date_of_birth,
    this.profile_image = null,
    this.cover_image = null,
    this.created_at = null,
    this.updated_at = null,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      user_id: json['user_id'],
      first_name: json['first_name'],
      password: json['first_name'],
      last_name: json['last_name'],
      sex: json['sex'],
      date_of_birth: json['date_of_birth'],
      profile_image: json['profile_image'] ?? 'no profile image',
      cover_image: json['cover_image'] ?? 'no cover image',
      created_at: json['created_at'] ?? 'user not created',
      updated_at: json['updated_at'] ?? 'user not updated',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'first_name': first_name,
      'last_name': last_name,
      'sex': sex,
      'date_of_birth': date_of_birth,
      'profile_image': profile_image,
      'password': password,
      'cover_image': cover_image,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int,
      user_id: map['user_id'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      sex: map['sex'] as String,
      date_of_birth: map['date_of_birth'] as String,
      profile_image:
          map['profile_image'] != null ? map['profile_image'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      cover_image:
          map['cover_image'] != null ? map['cover_image'] as String : null,
      created_at:
          map['created_at'] != null ? map['created_at'] as String : null,
      updated_at:
          map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
