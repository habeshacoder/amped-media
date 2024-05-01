import 'package:ampedmedia_flutter/dashboard.dart';
import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/allaudiobooks.dart';
import 'package:ampedmedia_flutter/view/allbooks.dart';
import 'package:ampedmedia_flutter/view/allmagazine.dart';
import 'package:ampedmedia_flutter/view/allnewspaper.dart';
import 'package:ampedmedia_flutter/view/allpodcast.dart';
import 'package:ampedmedia_flutter/view/detailview/bookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoreFromAuthor extends StatefulWidget {
  MoreFromAuthor({required this.book, required this.typeOfmaterial});
  final MaterialModel book;
  String typeOfmaterial;
  @override
  State<MoreFromAuthor> createState() => _MoreFromAuthorState();
}

class _MoreFromAuthorState extends State<MoreFromAuthor> {
  String? token;
  @override
  void didChangeDependencies() {
    print('profiledisppkayinfo...........');

    token = Provider.of<Auth>(context, listen: false).token;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF28464B),
      ),
      margin: EdgeInsets.only(top: 12),
      height: 287,
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'More from the publisher',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                getPage(widget.typeOfmaterial)));
                      },
                      child: Text(
                        'more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                // Text('we collect some books base on your interest')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13, left: 10),
            // color: Colors.yellow,
            height: 225,
            child: Consumer<materialCreationProvider>(
                builder: (context, material, child) => FutureBuilder(
                      future: material.getMaterialByAuthor(
                          widget.book.sellerProfile_id,
                          isFromMoreDetailView: true),
                      builder: (context, snapshot) {
                        print(
                            'materials in fututre builder:....${snapshot.data}');
                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => BookDetailView(
                                          book: snapshot.data![index]),
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFFFFFFFF).withOpacity(0.07),
                                            Color(0xFFFFFFFF).withOpacity(0.06),
                                          ],
                                        ),

                                        // color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    // height: 220,
                                    width: 132,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 130,
                                          child: Image(
                                            fit: BoxFit.scaleDown,
                                            image: NetworkImage(
                                                '${BackEndUrl.url}/material/material_cover/${snapshot.data![index].id}'),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            top: 1,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  '${snapshot.data![index].title}',
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  FutureBuilder(
                                                    future: material.getAvgRate(
                                                        token,
                                                        snapshot
                                                            .data![index].id),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        print(
                                                            'avge of each material:...${snapshot.data}');
                                                        return Row(
                                                          children: [
                                                            Text(
                                                              '${snapshot.data}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              width: 3.3,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                          ],
                                                        );
                                                      }
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return CircularProgressIndicator();
                                                      }
                                                      return Text('');
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        if (snapshot.data![index].author !=
                                            null)
                                          Text(
                                              '${snapshot.data![index].author}',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                              )),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        if (snapshot.data![index]
                                                .first_published_at !=
                                            null)
                                          SizedBox(
                                            height: 3,
                                          ),
                                        Text(
                                            '${snapshot.data![index].price} Birr',
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return Text('no available data');
                      },
                    )),
          )
        ],
      ),
    );
  }

  Widget getPage(String mediaType) {
    dynamic page;

    switch (mediaType) {
      case 'AudioBook':
        page = AllAudioBooks();
        break;
      case 'Book':
        page = AllBooks();
        break;
      case 'Magazine':
        page = AllMagazine();
        break;
      case 'NewsPaper':
        page = AllNewsPapers();
        break;
      case 'Podcast':
        page = AllPodcasts();
        break;
      default:
        page = DashBoard();
        break;
    }
    return page;
  }
}
