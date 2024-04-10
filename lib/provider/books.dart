import 'package:ampedmedia_flutter/model/book.dart';
import 'package:flutter/cupertino.dart';

class Books with ChangeNotifier {
  List<Book> _itemBooks = [
    Book(
      publishedDate: DateTime.now(),
      id: 'p1',
      title: 'hasetegnaw',
      author: 'alemayehu gelagay',
      price: 29.99,
      imageUrl: 'assets/images/demuuyimages/huletukhlotochaudiobook.png',
    ),
    Book(
      publishedDate: DateTime.now(),
      id: 'p1',
      title: 'hasetegnaw',
      author: 'alemayehu gelagay',
      price: 29.99,
      imageUrl: 'assets/images/demuuyimages/huletukhlotochaudiobook.png',
    ),
    Book(
      publishedDate: DateTime.now(),
      id: 'p1',
      title: 'hasetegnaw',
      author: 'alemayehu gelagay',
      price: 29.99,
      imageUrl: 'assets/images/demuuyimages/huletukhlotochaudiobook.png',
    ),
    Book(
      publishedDate: DateTime.now(),
      id: 'p1',
      title: 'hasetegnaw',
      author: 'alemayehu gelagay',
      price: 29.99,
      imageUrl: 'assets/images/demuuyimages/huletukhlotochaudiobook.png',
    ),
  ];
  List<Book> get booksList {
    return _itemBooks;
  }
}
