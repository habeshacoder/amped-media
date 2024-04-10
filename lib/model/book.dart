import 'package:flutter/widgets.dart';

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final DateTime publishedDate;
  double rate;
  bool isFavorite;
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    this.rate = 0.0,
    this.isFavorite = false,
    required this.publishedDate,
  });
}
