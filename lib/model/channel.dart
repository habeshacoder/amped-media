import 'package:flutter/widgets.dart';

class Channel with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String category;

  Channel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
  });
}
