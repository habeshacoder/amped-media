import 'package:ampedmedia_flutter/model/channelmodel.dart';
import 'package:ampedmedia_flutter/provider/channelcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllChannels extends StatefulWidget {
  static final routeName = '/allChannels';
  const AllChannels({super.key});

  @override
  State<AllChannels> createState() => _AllChannelsState();
}

class _AllChannelsState extends State<AllChannels> {
  late Future<List<ChannelModel>> channelList;
  String? token;
  @override
  void didChangeDependencies() {
    print('get top books info display didchangedepcey ...........');
    channelList = Provider.of<ChannelCreationProvider>(context, listen: false)
        .seeAllChannel();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
        Image(image: AssetImage('assets/images/filter.png')),
        Image(image: AssetImage('assets/images/Notification.png')),
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
              'Channels',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: channelList,
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
                  itemBuilder: (context, index) => Container(
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
                                    '${BackEndUrl.url}/channel/channel_cover/${snapshot.data![index].id}')),
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
                                    '${snapshot.data![index].name}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                                height: 30,
                                margin: EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 2, color: Color(0xFF00A19A)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xFF00A19A),
                                    ),
                                    Text(
                                      'Subscribe',
                                      style: TextStyle(
                                        color: Color(0xFF00A19A),
                                      ),
                                    ),
                                  ],
                                )
                                // child: Text('Sign Up'),
                                ),
                          ),
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
