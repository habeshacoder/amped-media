import 'package:ampedmedia_flutter/view/SearchPage.dart';
import 'package:ampedmedia_flutter/widget/home/newaudiobooks.dart';
import 'package:ampedmedia_flutter/widget/home/popular_magazine.dart';
import 'package:ampedmedia_flutter/widget/home/popular_newspaper.dart';
import 'package:ampedmedia_flutter/widget/home/popularpodcast.dart';
import 'package:ampedmedia_flutter/widget/home/topbooks.dart';
import 'package:ampedmedia_flutter/widget/home/toppublicationchannels.dart';
import 'package:ampedmedia_flutter/widget/home/topscroll.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static final routeName = '/Home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _refresh(BuildContext context) async {
    await Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.70,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'search by titel, author, or topic',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Image(image: AssetImage('assets/images/filter.png')),
          // Image(image: AssetImage('assets/images/Notification.png')),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 230, child: TopScrolls()),
              TopBooks(),
              NewAudioBooks(),
              PopularPodcasts(),
              PopularMagazines(),
              PopularNewspaper(),
              TopPublicationChannels(),
            ],
          ),
        ),
      ),
    );
  }
}
