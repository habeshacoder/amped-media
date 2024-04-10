import 'package:ampedmedia_flutter/model/channel.dart';
import 'package:flutter/cupertino.dart';

class Channels with ChangeNotifier {
  List<Channel> _itemChannels = [
    Channel(
        id: 'c1',
        title: 'ethiopian business review',
        imageUrl: 'assets/images/demuuyimages/chennel.png',
        category: 'Book'),
    Channel(
        id: 'c1',
        title: 'ethiopian business review',
        imageUrl: 'assets/images/demuuyimages/chennel.png',
        category: 'Book'),
    Channel(
        id: 'c1',
        title: 'ethiopian business review',
        imageUrl: 'assets/images/demuuyimages/chennel.png',
        category: 'Book'),
    Channel(
        id: 'c1',
        title: 'ethiopian business review',
        imageUrl: 'assets/images/demuuyimages/chennel.png',
        category: 'Book'),
  ];
  List<Channel> get channelsgeter {
    return _itemChannels;
  }
}
