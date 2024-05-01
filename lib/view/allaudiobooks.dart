import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/audiobooks.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/detailview/audiobookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAudioBooks extends StatefulWidget {
  static final routeName = '/AllAudioBooks';
  const AllAudioBooks({super.key});

  @override
  State<AllAudioBooks> createState() => All_AudioBooksState();
}

class All_AudioBooksState extends State<AllAudioBooks> {
  Future<List<MaterialModel>>? materialList;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    materialList = Provider.of<materialCreationProvider>(context, listen: false)
        .getMaterialByType('Audiobook');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Audiobooks audioBooksObject = Provider.of<Audiobooks>(context);
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
              'Audiobooks',
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
                            AudioBookDetail(book: snapshot.data![index]),
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
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 3,
                            // ),
                            Text(
                              '${snapshot.data![index].reader}',
                            ),
                            // SizedBox(
                            //   height: 3,
                            // ),
                            Text(
                              '${snapshot.data![index].author}',
                            ),
                            // SizedBox(
                            //   height: 3,
                            // ),
                            Text('${snapshot.data![index].price}'),
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
      ),
    );
  }
}
