import 'package:ampedmedia_flutter/model/podcast.dart';
import 'package:flutter/cupertino.dart';

class Podcasts with ChangeNotifier {
  List<Podcast> _itemPodcast = [
    Podcast(
        id: 'pc1',
        title: 'Mind Set',
        episode: 24,
        imageUrl: 'assets/images/demuuyimages/mindsetpodcast.png'),
    Podcast(
        id: 'pc1',
        title: 'Mind Set',
        episode: 24,
        imageUrl: 'assets/images/demuuyimages/mindsetpodcast.png'),
    Podcast(
        id: 'pc1',
        title: 'Mind Set',
        episode: 24,
        imageUrl: 'assets/images/demuuyimages/mindsetpodcast.png'),
  ];
  List<Podcast> get podcastsList {
    return _itemPodcast;
  }
}
