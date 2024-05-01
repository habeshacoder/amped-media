import 'dart:convert';

import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/books.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/detailview/bookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllBooks extends StatefulWidget {
  static final routeName = '/AllBooks';
  const AllBooks({super.key});

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
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
              .getMaterialByType('Book');
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
          "parent": "Publication",
          "type": "Book",
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
              .getMaterialByType('Book');
    });
  }

  @override
  Widget build(BuildContext context) {
    Books booksObject = Provider.of<Books>(context);
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
              'Books',
              style: TextStyle(color: Colors.black, fontSize: 24),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      '${snapshot.data![index].title}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       '2.3',
                                  //     ),
                                  //     SizedBox(
                                  //       width: 3.3,
                                  //     ),
                                  //     Icon(
                                  //       Icons.star,
                                  //       size: 15,
                                  //     )
                                  //   ],
                                  // )
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
                            Text(
                              '${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![index].created_at!))}',
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text('${snapshot.data![index].price} birr'),
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
