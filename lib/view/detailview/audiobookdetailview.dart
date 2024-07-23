import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/model/rate.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/widget/morefromauthor.dart';
import 'package:ampedmedia_flutter/widget/seemore.dart';
import 'package:ampedmedia_flutter/widget/writingreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widget/report.dart';

class AudioBookDetail extends StatefulWidget {
  AudioBookDetail({required this.book});
  final MaterialModel book;
  @override
  State<AudioBookDetail> createState() => _AudioBookDetailState();
}

class _AudioBookDetailState extends State<AudioBookDetail> {
  dynamic totalRating = 0;
  dynamic avgRating = 0;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark, // dark text for status bar
      ),
    );
    super.initState();
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

  late Future<List<Rate>> userRates;
  // Future<List<MaterialModel>>? materialData;

  String? token;
  @override
  void didChangeDependencies() {
    print('profiledisppkayinfo...........');

    token = Provider.of<Auth>(context, listen: false).token;
    userRates = Provider.of<materialCreationProvider>(context, listen: false)
        .getRates(token, widget.book.id);
    // materialData = Provider.of<materialCreationProvider>(context, listen: false)
    //     .getMaterialByType('Book');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          '${widget.book.title}  Audiobook Detail',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.bookmark_border_outlined,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     // Add action here
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.notifications_none_sharp, color: Colors.black),
          //   onPressed: () {
          //     // Add action here
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
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
                children: [
                  Container(
                    height: 140,
                    child: Card(
                      elevation: 5,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.rectangle,
                            ),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  headers: {},
                                  '${BackEndUrl.url}/material/material_cover/${widget.book.material_image}'),
                            ),
                          ),
                          Positioned(
                            // bottom: 0,
                            top: 100,
                            left: 5,
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      headers: {},
                                      '${BackEndUrl.url}/material/material_profile/${widget.book.id}')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text('${widget.book.title}'),
                  Text('${widget.book.author}'),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Color(0xFF00A19A),
                          borderRadius: BorderRadius.circular(3)),
                      child: Text('${widget.book.price}')),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              color: Colors.grey[300],
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('rate'),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: userRates,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            snapshot.data!.forEach((element) {
                              totalRating = totalRating + element.rating;
                            });
                            avgRating = totalRating / snapshot.data!.length;
                            return Text('${avgRating}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          return Text('no rate');
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number of pages'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${widget.book.length_page}'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('created date'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${widget.book.created_at}'))}',
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Report(
              material_id: widget.book.id,
            ),
            Container(
              color: Colors.grey[200],
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Audiobook description', style: TextStyle(fontSize: 18)),
                  SeeMoreWidget(description: '${widget.book.description}'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text('more about the Audiobook',
                  style: TextStyle(fontSize: 18)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              color: Colors.grey[200],
              height: 100,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('language'),
                  Text('${widget.book.language}'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('The Auther:'),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${widget.book.author}'),
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
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //           child: Text('preview')),
            //       Container(
            //           decoration: BoxDecoration(
            //               color: Color(0xFF00A19A),
            //               borderRadius: BorderRadius.circular(5)),
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //           child: Text('buy now')),
            //     ],
            //   ),
            // ),
            Divider(),
            Consumer<Auth>(
              builder: (context, auth, child) => Card(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                        final ratingvalue = snapshot.data![index].rating * 1.0;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10, top: 5),
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
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
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
            ),
            MoreFromAuthor(
              book: widget.book,
              typeOfmaterial: 'AudioBook',
            ),
          ],
        ),
      ),
    );
  }

  void checksSignIn(Auth auth, MaterialModel book) {
    if (auth.isAuth == false) {
      showalert('Please sign in first to rate this material');
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WrittingReview(book: book),
    ));
  }
}
