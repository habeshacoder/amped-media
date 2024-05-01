import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/provider/podcasts.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ampedmedia_flutter/view/detailview/podcastdetailview.dart';

class AllPodcasts extends StatefulWidget {
  static final routeName = '/AllPodcasts';
  const AllPodcasts({super.key});

  @override
  State<AllPodcasts> createState() => All_AudioBooksState();
}

class All_AudioBooksState extends State<AllPodcasts> {
  late Future<List<MaterialModel>> materialList;
  String? token;
  @override
  void didChangeDependencies() {
    print('get  all podcasts info display didchangedepcey ...........');
    materialList = Provider.of<materialCreationProvider>(context, listen: false)
        .getMaterialByType('Podcast');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Podcasts audioBooksObject = Provider.of<Podcasts>(context);
    var appBar = AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      elevation: 0.5,
      actions: [
        // Image(image: AssetImage('assets/images/filter.png')),
        // Image(image: AssetImage('assets/images/Notification.png')),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              'Podcasts',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: materialList,
            builder: (context, snapshot) {
              print('materialList.....:');
              print(materialList);
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5 / 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PodcastDetailView(book: snapshot.data![index]),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${snapshot.data![index].episode}'),
                              Text('Episodes'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    heightFactor: 10,
                    widthFactor: 10,
                    child: CircularProgressIndicator());
              }
              // return Text('no available data');
              return Center(
                  heightFactor: 10,
                  widthFactor: 10,
                  child: Text('Please try later'));
            },
          )),
        ],
      ),
    );
  }
}
