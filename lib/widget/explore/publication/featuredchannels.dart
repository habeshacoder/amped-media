import 'package:ampedmedia_flutter/provider/channels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedChannels extends StatelessWidget {
  const FeaturedChannels({super.key});

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
                      'Featured Publication Channels',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'more',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A19A)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            // color: Colors.yellow,
            height: 230,
            child: Consumer<Channels>(
              builder: (context, channels, child) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: channels.channelsgeter.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 230,
                  width: 132,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                channels.channelsgeter[index].imageUrl)),
                      ),
                      Text(
                        '${channels.channelsgeter[index].title}',
                        softWrap: true,
                      ),
                      Text('${channels.channelsgeter[index].category}'),
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
            ),
          )
        ],
      ),
    );
  }
}
