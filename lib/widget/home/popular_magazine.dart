import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/allmagazine.dart';
import 'package:ampedmedia_flutter/view/allpodcast.dart';
import 'package:ampedmedia_flutter/view/detailview/magazinedetailview.dart';
import 'package:ampedmedia_flutter/view/detailview/podcastdetailview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PopularMagazines extends StatefulWidget {
  const PopularMagazines({super.key});

  @override
  State<PopularMagazines> createState() => _PopularMagazinesState();
}

class _PopularMagazinesState extends State<PopularMagazines> {
  late Future<List<MaterialModel>> materialFetched;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    materialFetched =
        Provider.of<materialCreationProvider>(context, listen: false)
            .getMaterialByType('Magazine');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      'Popular Magazines',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllMagazine(),
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
                Text('these are popular and trending Magazines')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            // color: Colors.yellow,
            height: 220,
            child: Consumer<materialCreationProvider>(
                builder: (context, material, child) => FutureBuilder(
                      future: materialFetched,
                      builder: (context, snapshot) {
                        print(materialFetched);
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MagazineDetailView(
                                      book: snapshot.data![index]),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(5)),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 185,
                                width: 132,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 140,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              headers: {},
                                              '${BackEndUrl.url}/material/material_cover/${snapshot.data![index].material_image}')),
                                    ),
                                    Text('${snapshot.data![index].title}'),
                                    Text('${snapshot.data![index].publisher}'),
                                    Text('${snapshot.data![index].price} birr'),
                                    Text(
                                      '${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![index].created_at))}',
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
                              widthFactor: 10,
                              heightFactor: 10,
                              child: CircularProgressIndicator());
                          // return CircularProgressIndicator();
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
