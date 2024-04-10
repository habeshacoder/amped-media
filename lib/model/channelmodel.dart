import 'package:flutter/material.dart';

class ChannelModel with ChangeNotifier {
  final int id;
  final String name;
  final int? Price;
  final int sellerProfile_id;
  final String description;
  final String? created_at;
  final String? updated_at;

  ChannelModel({
    required this.id,
    this.Price,
    required this.sellerProfile_id,
    required this.name,
    required this.description,
    this.created_at = null,
    this.updated_at = null,
  });
  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      Price: json['Price'],
      name: json['name'],
      sellerProfile_id: json['sellerProfile_id'],
      description: json['description'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
