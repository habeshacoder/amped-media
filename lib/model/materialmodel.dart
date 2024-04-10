import 'package:flutter/material.dart';

class MaterialModel with ChangeNotifier {
  final int id;
  final int sellerProfile_id;
  final String parent;
  final String type;
  final String genere;
  final int price;
  final String catagory;
  final String? author;
  final String? reader;
  final String? translator;
  final int? length_minute;
  final int? length_page;
  final dynamic first_published_at;
  final String? language;
  final String? publisher;
  final int? episode;
  final int? continues_from;
  final String? material;
  final String? title;
  final String? description;
  final dynamic created_at;
  final dynamic updated_at;

  MaterialModel({
    required this.id,
    required this.sellerProfile_id,
    required this.parent,
    required this.type,
    required this.genere,
    required this.catagory,
    required this.price,
    this.author,
    this.continues_from,
    this.created_at,
    this.episode,
    this.title,
    this.description,
    this.first_published_at,
    this.language,
    this.length_minute,
    this.length_page,
    this.material,
    this.publisher,
    this.reader,
    this.translator,
    this.updated_at,
  });
  factory MaterialModel.fromJson(dynamic json) {
    return MaterialModel(
      id: json['id'],
      sellerProfile_id: json['sellerProfile_id'],
      catagory: json['catagory'].toString(),
      description: json['description'].toString(),
      first_published_at: json['first_published_at'],
      genere: json['genere'].toString(),
      language: json['language'].toString(),
      length_minute: json['length_minute'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      length_page: json['length_page'],
      material: json['material'].toString(),
      parent: json['parent'].toString(),
      price: json['price'],
      publisher: json['publisher'].toString(),
      reader: json['reader'].toString(),
      title: json['title'].toString(),
      translator: json['translator'].toString(),
      type: json['type'].toString(),
      author: json['author'].toString(),
      continues_from: json['continues_from'],
      episode: json['episode'],
    );
  }
}
