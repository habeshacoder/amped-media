import 'package:ampedmedia_flutter/model/audiobook.dart';
import 'package:flutter/cupertino.dart';

class Audiobooks with ChangeNotifier {
  List<Audiobook> _itemAudiobooks = [
    Audiobook(
      id: 'ab1',
      title: 'two skilss',
      storyteller: 'alemayehu gelagay',
      writer: 'alemayehu gelagay',
      length: 1.3,
      price: 130,
      imageUrl: 'assets/images/demuuyimages/mindsetpodcast.png',
    ),
    Audiobook(
      id: 'ab2',
      title: 'two skilss',
      storyteller: 'alemayehu gelagay',
      writer: 'alemayehu gelagay',
      length: 1.3,
      price: 130,
      imageUrl: 'assets/images/demuuyimages/mindsetpodcast.png',
    ),
    Audiobook(
      id: 'ab3',
      title: 'two skilss',
      storyteller: 'alemayehu gelagay',
      writer: 'alemayehu gelagay',
      length: 1.3,
      price: 130,
      imageUrl: 'assets/images/demuuyimages/mindsetpodcast.png',
    ),
  ];
  List<Audiobook> get audiobooksList {
    return _itemAudiobooks;
  }
}
