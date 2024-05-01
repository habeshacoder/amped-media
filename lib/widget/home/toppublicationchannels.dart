import 'package:ampedmedia_flutter/model/channelmodel.dart';
import 'package:ampedmedia_flutter/provider/channelcreationprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/detailview/channeldetailviews/audiobookchanneldetailview.dart';
import 'package:ampedmedia_flutter/view/allchannnels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPublicationChannels extends StatefulWidget {
  const TopPublicationChannels({super.key});

  @override
  State<TopPublicationChannels> createState() => _TopPublicationChannelsState();
}

class _TopPublicationChannelsState extends State<TopPublicationChannels> {
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
                      'Top Publication Channels',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllChannels(),
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
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            // color: Colors.yellow,
            height: 180,
            child: Consumer<ChannelCreationProvider>(
                builder: (context, channel, child) => FutureBuilder(
                      future: channelList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookChannelDetailView(
                                      book: snapshot.data![index]),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(5)),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 150,
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
                                              '${BackEndUrl.url}/channel/channel_profile/${snapshot.data![index].id}')),
                                    ),
                                    Text(
                                      '${snapshot.data![index].name}',
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // return CircularProgressIndicator();
                          return Center(
                              widthFactor: 10,
                              heightFactor: 10,
                              child: CircularProgressIndicator());
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
