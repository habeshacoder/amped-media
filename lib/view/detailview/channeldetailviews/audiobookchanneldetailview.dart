import 'package:ampedmedia_flutter/model/channelmodel.dart';
import 'package:ampedmedia_flutter/model/rate.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/channelcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/SearchPage.dart';
import 'package:ampedmedia_flutter/widget/reviewchannel.dart';
import 'package:ampedmedia_flutter/widget/seemore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookChannelDetailView extends StatefulWidget {
  BookChannelDetailView({required this.book});
  final ChannelModel book;
  @override
  State<BookChannelDetailView> createState() => _BookChannelDetailViewState();
}

class _BookChannelDetailViewState extends State<BookChannelDetailView> {
  double _rating = 0;
  dynamic totalRating = 0;
  dynamic avgRating = 0;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    // SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  late Future<List<Rate>> userRates;
  String? token;
  @override
  void didChangeDependencies() {
    print('profiledisppkayinfo...........');

    token = Provider.of<Auth>(context, listen: false).token;
    userRates = Provider.of<ChannelCreationProvider>(context, listen: false)
        .getRates(token, widget.book.id);
    super.didChangeDependencies();
  }

  void showalert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('an error occured'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('okay'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        height: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(dimension.width)),
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  headers: {},
                                  '${BackEndUrl.url}/channel/channel_cover/${widget.book.id}')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      headers: {},
                                      '${BackEndUrl.url}/channel/channel_profile/${widget.book.id}')),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.book.name}'),
                                Text(
                                  '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${widget.book.created_at}'))}',
                                  softWrap: true,
                                ),
                                Row(
                                  children: [
                                    FutureBuilder(
                                      future: userRates,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          snapshot.data!.forEach((element) {
                                            totalRating =
                                                totalRating + element.rating;
                                          });
                                          avgRating = totalRating /
                                              snapshot.data!.length;
                                          return Text('${avgRating}');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        }
                                        return Text('no rate');
                                      },
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text('User Rating'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text('${widget.book.description}')),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         height: 40,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             border: Border.all(
                      //                 width: 1, color: Color(0xFF00A19A))),
                      //         child: Center(
                      //           child: TextButton.icon(
                      //             label: Text(
                      //               'Subscribe',
                      //               style: TextStyle(
                      //                   color: Color(0xFF00A19A), fontSize: 14),
                      //             ),
                      //             icon: Icon(
                      //               Icons.add,
                      //               color: Color(0xFF00A19A),
                      //             ),
                      //             onPressed: () {
                      //               // Do something when the button is pressed
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 7,
                      //       ),
                      //       if (widget.book.Price != null)
                      //         Text(
                      //           '${widget.book.Price} Birr/Month',
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //       if (widget.book.Price == null)
                      //         Text('price is not available')
                      //     ],
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const SearchPage()));
                      //   },
                      //   child: Center(
                      //     child: Container(
                      //       height: 35,
                      //       width: MediaQuery.of(context).size.width * 0.90,
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[350],
                      //         border: Border.all(
                      //           color: Colors.grey[300]!,
                      //           width: 1,
                      //         ),
                      //         borderRadius: BorderRadius.circular(25),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.symmetric(horizontal: 10),
                      //             child: Icon(
                      //               Icons.search,
                      //               color: Colors.grey,
                      //             ),
                      //           ),
                      //           Text(
                      //             'search by titel, author, or topic',
                      //             softWrap: true,
                      //             style: TextStyle(
                      //               fontSize: 12,
                      //               color: Colors.black38,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Divider(),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                //   height: 50,
                //   width: double.infinity,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Container(
                //           decoration: BoxDecoration(
                //               color: Colors.grey[200],
                //               borderRadius: BorderRadius.circular(5)),
                //           padding: EdgeInsets.symmetric(
                //               horizontal: 20, vertical: 10),
                //           child: Text('preview')),
                //       Container(
                //           decoration: BoxDecoration(
                //               color: Color(0xFF00A19A),
                //               borderRadius: BorderRadius.circular(5)),
                //           padding: EdgeInsets.symmetric(
                //               horizontal: 20, vertical: 10),
                //           child: Text('buy now')),
                //     ],
                //   ),
                // ),
                Divider(),
                Consumer<Auth>(
                  builder: (context, auth, child) => Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'add your review here',
                                style: TextStyle(fontSize: 18),
                              )),
                          InkWell(
                            onTap: () => checksSignIn(auth, widget.book),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.star_border)),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.star_border)),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.star_border)),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.star_border)),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.star_border))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => checksSignIn(auth, widget.book),
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'review here',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF00A19A),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: userRates,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        // height: 130,
                        height: 142,
                        child: ListView.builder(
                          shrinkWrap: true,
                          // physics:ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final ratingvalue =
                                snapshot.data![index].rating * 1.0;
                            return Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              width: 290,
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 1,
                                child: Container(
                                  // height: 112,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 10, top: 5),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('adoni'),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${snapshot.data![index].created_at}',
                                            ),
                                            // Text(
                                            //   ' ${DateFormat.yMd().format(snapshot.data![index].created_at as DateTime)}',
                                            // ),
                                          ],
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: ratingvalue,
                                        minRating: 1,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 25,
                                        // unratedColor: Colors.grey[400],
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {
                                          print('.....rating');
                                        },
                                      ),
                                      SeeMoreWidget(
                                          description:
                                              '${snapshot.data![index].remark}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Text('');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checksSignIn(Auth auth, ChannelModel book) {
    if (auth.isAuth == false) {
      showalert('Please sign in first to rate this material');
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ReviewChannel(book: book),
    ));
  }
}
