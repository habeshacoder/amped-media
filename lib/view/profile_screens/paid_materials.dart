import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../model/materialmodel.dart';
import '../../provider/materialcreationprovider.dart';
import '../../url.dart';

class PaidMaterial extends StatefulWidget {
  const PaidMaterial({super.key});

  @override
  State<PaidMaterial> createState() => _PaidMaterialState();
}

class _PaidMaterialState extends State<PaidMaterial> {
  late Future<List<MaterialModel>> materialFetched;
  String? token;
  @override
  void didChangeDependencies() {
    token = Provider.of<Auth>(context, listen: false).token;
    print(token);
    materialFetched =
        Provider.of<materialCreationProvider>(context, listen: false)
            .getMaterialPaidMaterials(token);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Paid Materials',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5)),
            height: 50,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    'Image',
                    softWrap: true,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    'Title',
                    softWrap: true,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    'Price',
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 13),
              // color: Colors.yellow,
              height: 220,
              child: Consumer<materialCreationProvider>(
                  builder: (context, material, child) => FutureBuilder(
                        future: materialFetched,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Center(child: Text('No Availanle Data'));
                          }
                          if (snapshot.data!.length == 0) {
                            return Center(child: Text('No Availanle Data'));
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5)),
                                  // margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                12,
                                        height: 40,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            headers: {},
                                            '${BackEndUrl.url}/material/material_cover/${snapshot.data![index].material_image}',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          '${snapshot.data![index].title ?? 'N/A'}',
                                          softWrap: true,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                          '${snapshot.data![index].price ?? 'N/A'}',
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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
            ),
          )
        ],
      ),
    );
  }
}
