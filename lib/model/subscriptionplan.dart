import 'package:flutter/material.dart';

class SubscriptionPlan with ChangeNotifier {
  final int id;
  final String name;
  final String description;
  final int? Price;
  final int channel_id;
  final String? created_at;
  final String? updated_at;

  SubscriptionPlan({
    required this.id,
    this.Price,
    required this.channel_id,
    required this.name,
    required this.description,
    this.created_at = null,
    this.updated_at = null,
  });
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      Price: json['Price'],
      name: json['name'],
      channel_id: json['channel_id'],
      description: json['description'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
