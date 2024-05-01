import 'package:ampedmedia_flutter/view/SearchPage.dart';
import 'package:ampedmedia_flutter/widget/library/audiobooklibrary.dart';
import 'package:ampedmedia_flutter/widget/library/booklibrary.dart';
import 'package:ampedmedia_flutter/widget/library/magazinelibrary.dart';
import 'package:ampedmedia_flutter/widget/library/podcastlibrary.dart';
import 'package:flutter/material.dart';

// enum LibraryType {
//   Books,
//   Audiobooks,
//   Podcasts,
//   Magazines,
// }

class Library extends StatefulWidget {
  static final routeName = '/Library';
  const Library({super.key});

  @override
  State<Library> createState() => _HomeState();
}

class _HomeState extends State<Library> {
  int libraryTypeIndex = 0;
  List<Widget> libraryWidgets = [
    BookLibrary(),
    AudioLibrary(),
    PodcastLibrary(),
    MagazineLibrary(),
  ];

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
      // appBar: appBar,
      body: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[50],
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 38,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          libraryTypeIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: libraryTypeIndex == 0
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'Books',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          libraryTypeIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: libraryTypeIndex == 1
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'Audiobooks',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          libraryTypeIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: libraryTypeIndex == 2
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'Podcasts',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          libraryTypeIndex = 3;
                        });
                      },
                      child: Container(
                        decoration: libraryTypeIndex == 3
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'Magazines',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: libraryWidgets[libraryTypeIndex],
      ),
    );
  }
}
