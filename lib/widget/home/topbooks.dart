import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/allbooks.dart';
import 'package:ampedmedia_flutter/view/detailview/bookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TopBooks extends StatefulWidget {
  const TopBooks({super.key});

  @override
  State<TopBooks> createState() => _TopBooksState();
}

class _TopBooksState extends State<TopBooks> {
  bool isGetMeRunning = false;
  dynamic totalRating = 0;
  dynamic avgRating = 0;
  Future<List<MaterialModel>>? userProfile;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    token = Provider.of<Auth>(context, listen: false).token;
    userProfile = Provider.of<materialCreationProvider>(context, listen: false)
        .getMaterialByType('Book');
    super.didChangeDependencies();
    isGetMeRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    print('get top books  build method.........');
    return Container(
      margin: EdgeInsets.only(top: 12),
      height: 287,
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Books Pics For You',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllBooks(),
                        ));
                      },
                      child: Text(
                        'more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00A19A)),
                      ),
                    ),
                  ],
                ),
                Text('we collect some books base on your interest')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            // color: Colors.yellow,
            height: 225,
            child: Consumer<materialCreationProvider>(
                builder: (context, material, child) => FutureBuilder(
                      future: userProfile,
                      builder: (context, snapshot) {
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
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    // height: 220,
                                    width: 132,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 120,
                                          child: Image(
                                            fit: BoxFit.scaleDown,
                                            image: NetworkImage(
                                                '${BackEndUrl.url}/material/material_cover/${snapshot.data![index].material_image}'),
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
                                                  style:
                                                      TextStyle(fontSize: 13),
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
                                                                '${snapshot.data}'),
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
                                              '${snapshot.data![index].author}'),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        // if (snapshot.data![index]
                                        //         .first_published_at !=
                                        //     null)
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            '${snapshot.data![index].price} Birr'),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              widthFactor: 10,
                              heightFactor: 10,
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('please try later'));
                        }
                        return Center(child: Text('Please try later'));
                      },
                    )),
          )
        ],
      ),
    );
  }
}
