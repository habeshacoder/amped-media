import 'package:flutter/material.dart';
import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/books.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/detailview/bookdetailview.dart';
import 'package:provider/provider.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  late Future<List<MaterialModel>> materialList;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    materialList = Provider.of<materialCreationProvider>(context, listen: false)
        .getMaterialByParent('Audio');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Books booksObject = Provider.of<Books>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
