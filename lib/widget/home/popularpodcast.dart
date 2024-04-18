import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/allpodcast.dart';
import 'package:ampedmedia_flutter/view/detailview/podcastdetailview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularPodcasts extends StatefulWidget {
  const PopularPodcasts({super.key});

  @override
  State<PopularPodcasts> createState() => _PopularPodcastsState();
}

class _PopularPodcastsState extends State<PopularPodcasts> {
  late Future<List<MaterialModel>> materialFetched;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    materialFetched =
        Provider.of<materialCreationProvider>(context, listen: false)
            .getMaterialByType('Podcast');
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
                      'Popular Podcasts',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllPodcasts(),
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
                Text('these are popular and trending podcasts')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            // color: Colors.yellow,
            height: 185,
            child: Consumer<materialCreationProvider>(
                builder: (context, material, child) => FutureBuilder(
                      future: materialFetched,
                      builder: (context, snapshot) {
                        print('material fetched:......:');
                        print(materialFetched);
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PodcastDetailView(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${snapshot.data![index].episode}'),
                                        Text('Ep'),
                                      ],
                                    )
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
