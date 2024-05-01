import 'dart:convert';

import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/provider/podcasts.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ampedmedia_flutter/view/detailview/podcastdetailview.dart';
import 'package:http/http.dart' as http;

class AllPodcasts extends StatefulWidget {
  static final routeName = '/AllPodcasts';
  const AllPodcasts({super.key});

  @override
  State<AllPodcasts> createState() => All_AudioBooksState();
}

class All_AudioBooksState extends State<AllPodcasts> {
  late Future<List<MaterialModel>> materialList;
  String? token;

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool init = true;
  @override
  void didChangeDependencies() {
    if (init == true) {
      print('get top books info display didchangedepcey ...........');
      materialList =
          Provider.of<materialCreationProvider>(context, listen: false)
              .getMaterialByType('Podcast');
    }
    init = false;
    super.didChangeDependencies();
  }

  //get  material by type
  Future<List<MaterialModel>> searchMaterial(String keyValue) async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/search';
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({
          "key": keyValue,
          "parent": "Audio",
          "type": "Podcast",
        }));
    print('search materil...${response.body}');

    List<MaterialModel> loadedMaterials = [];

    final extractedResponse = json.decode(response.body);
    print('search extracted response...${extractedResponse}');
    print('search extracted mainmatch...${extractedResponse["mainMatches"]}');

    try {
      extractedResponse["mainMatches"].forEach((mat) {
        loadedMaterials.add(MaterialModel.fromJson(mat));
      });
      print("loadedmaterials-------------${loadedMaterials}");
    } catch (error) {
      print('eror......:${error}');
    }
    return loadedMaterials;
  }

  void onSearch(String searchText) {
    setState(() {
      isSearching = true;
      materialList = searchMaterial(searchText.trim());
    });
  }

  void clearSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      materialList =
          Provider.of<materialCreationProvider>(context, listen: false)
              .getMaterialByType('Podcast');
    });
  }

  @override
  Widget build(BuildContext context) {
    Podcasts audioBooksObject = Provider.of<Podcasts>(context);
    var appBar = AppBar(
      title: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onSubmitted: onSearch,
            decoration: InputDecoration(
              hintText: 'Search by title',
              suffixIcon: isSearching
                  ? IconButton(
                      onPressed: clearSearch,
                      icon: Icon(Icons.clear),
                    )
                  : Icon(Icons.search),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.5,
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
                          Text('${snapshot.data![index].price} birr'),
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
