import 'package:flutter/widgets.dart';

class Audiobook with ChangeNotifier {
  final String id;
  final String title;
  final String writer;
  final String storyteller;
  final double length;
  final double price;
  final String imageUrl;
  double rate;
  bool isFavorite;
  Audiobook({
    required this.id,
    required this.title,
    required this.storyteller,
    required this.writer,
    required this.length,
    required this.price,
    required this.imageUrl,
    this.rate = 0.0,
    this.isFavorite = false,
  });
}
