import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/books.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/detailview/bookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnspecifiedView extends StatefulWidget {
  const UnspecifiedView({super.key});

  @override
  State<UnspecifiedView> createState() => _PublicationState();
}

class _PublicationState extends State<UnspecifiedView> {
  late Future<List<MaterialModel>> materialList;
  TextEditingController searchController = TextEditingController();

  String? token;
  bool isSearching = false;
  bool init = true;
  @override
  void didChangeDependencies() {
    if (init == true) {
      print('get top books info display didchangedepcey ...........');
      materialList =
          Provider.of<materialCreationProvider>(context, listen: false)
              .getMaterialByParent('Unspecified');
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
          "parent": "Unspecified",
          "type": "Unspecified",
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
              .getMaterialByParent('Publication');
    });
  }

  @override
  Widget build(BuildContext context) {
    Books booksObject = Provider.of<Books>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
        Expanded(
            child: FutureBuilder(
          future: materialList,
          builder: (context, snapshot) {
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
                          BookDetailView(book: snapshot.data![index]),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    // height: 500,
                    // width: 132,

                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5)),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 220,
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
                          Container(
                            padding: const EdgeInsets.only(
                              top: 1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    '${snapshot.data![index].title}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text('${snapshot.data![index].author}'),
                          SizedBox(
                            height: 3,
                          ),
                          // Text('${snapshot.data![index].first_published_at}'),
                          SizedBox(
                            height: 3,
                          ),
                          Text('${snapshot.data![index].price}'),
                          Text('${snapshot.data![index].catagory}'),
                        ],
                      ),
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
    );
  }
}
