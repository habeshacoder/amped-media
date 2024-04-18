import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/allaudiobooks.dart';
import 'package:ampedmedia_flutter/view/detailview/audiobookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAudioBooks extends StatefulWidget {
  const NewAudioBooks({super.key});

  @override
  State<NewAudioBooks> createState() => _NewAudioBooksState();
}

class _NewAudioBooksState extends State<NewAudioBooks> {
  late Future<List<MaterialModel>> userProfile;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    token = Provider.of<Auth>(context, listen: false).token;
    userProfile = Provider.of<materialCreationProvider>(context, listen: false)
        .getMaterialByType('Audiobook');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 287,
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
                      'New Arrived Audiobooks',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllAudioBooks(),
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
                Text('Listen out new audiobooks')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            // color: Colors.yellow,
            height: 220,
            child: Consumer<materialCreationProvider>(
                builder: (context, books, child) => FutureBuilder(
                      future: userProfile,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AudioBookDetail(
                                      book: snapshot.data![index]),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(5)),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 170,
                                width: 132,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              headers: {},
                                              '${BackEndUrl.url}/material/material_cover/${snapshot.data![index].material_image}')),
                                    ),
                                    if (snapshot.data![index].title != null)
                                      Text('${snapshot.data![index].title}'),
                                    if (snapshot.data![index].reader != null)
                                      Text('${snapshot.data![index].reader}'),
                                    if (snapshot.data![index].author != null)
                                      Text('${snapshot.data![index].author}'),
                                    if (snapshot.data![index].length_minute !=
                                        null)
                                      Text(
                                          '${snapshot.data![index].length_minute} min'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${snapshot.data![index].price} Birr'),
                                        Row(
                                          children: [
                                            FutureBuilder(
                                              future: books.getAvgRate(token,
                                                  snapshot.data![index].id),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(
                                                      'avge of each material in top arrived audio books:...${snapshot.data}');
                                                  return Row(
                                                    children: [
                                                      Text('${snapshot.data}'),
                                                      SizedBox(
                                                        width: 3.3,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      )
                                                    ],
                                                  );
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                }
                                                return Text('');
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              heightFactor: 10,
                              widthFactor: 10,
                              child: CircularProgressIndicator());
                        }
                        return Center(child: Text('Please try later'));
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
