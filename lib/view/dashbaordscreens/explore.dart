import 'package:ampedmedia_flutter/view/SearchPage.dart';
import 'package:ampedmedia_flutter/widget/explore/audio/audio.dart';
import 'package:ampedmedia_flutter/widget/explore/publication/publication.dart';
import 'package:ampedmedia_flutter/widget/explore/unspecified/unspecified.dart';
import 'package:flutter/material.dart';

enum ExploreType {
  publication,
  // audio,
  Unspecified,
}

class Explore extends StatefulWidget {
  static final routeName = '/Explore';
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  var exploreTypeEnum = ExploreType.publication;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
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
      body: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(25.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0.5,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              exploreTypeEnum = ExploreType.publication;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    exploreTypeEnum == ExploreType.publication
                                        ? BorderSide(
                                            width: 1.5,
                                            color: Color(0xFF00A19A),
                                          )
                                        : BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                              ),
                            ),
                            child: Text(
                              'Publication',
                              style: TextStyle(
                                color:
                                    exploreTypeEnum == ExploreType.publication
                                        ? Color(0xFF00A19A)
                                        : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       exploreTypeEnum = ExploreType.audio;
                        //     });
                        //   },
                        //   child: Container(
                        //       decoration: BoxDecoration(
                        //         border: Border(
                        //           bottom: exploreTypeEnum == ExploreType.audio
                        //               ? BorderSide(
                        //                   width: 1.5,
                        //                   color: Color(0xFF00A19A),
                        //                 )
                        //               : BorderSide(
                        //                   width: 0,
                        //                   color: Colors.white,
                        //                 ),
                        //         ),
                        //       ),
                        //       child: Text('Audio',
                        //           style: TextStyle(
                        //             color: exploreTypeEnum == ExploreType.audio
                        //                 ? Color(0xFF00A19A)
                        //                 : Colors.grey,
                        //           ))),
                        // ),
                        SizedBox(
                          width: 13,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              exploreTypeEnum = ExploreType.Unspecified;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      exploreTypeEnum == ExploreType.Unspecified
                                          ? BorderSide(
                                              width: 1.5,
                                              color: Color(0xFF00A19A),
                                            )
                                          : BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                ),
                              ),
                              child: Text('Unspecified',
                                  style: TextStyle(
                                    color: exploreTypeEnum ==
                                            ExploreType.Unspecified
                                        ? Color(0xFF00A19A)
                                        : Colors.grey,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: exploreTypeEnum == ExploreType.publication
                ? Publication()
                : UnspecifiedView()
            // : Audio(),
            ),
      ),
    );
  }
}
