import 'package:ampedmedia_flutter/model/publisherprofilemodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/publisherprofileprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayPublisherProfileInfo extends StatefulWidget {
  const DisplayPublisherProfileInfo({super.key});

  @override
  State<DisplayPublisherProfileInfo> createState() =>
      _DisplayPublisherProfileInfoState();
}

class _DisplayPublisherProfileInfoState
    extends State<DisplayPublisherProfileInfo> {
  bool isInit = true;
  bool isGetMeRunning = false;
  late Future<PublisherProfileModel> userProfile;
  String? token;
  @override
  void didChangeDependencies() {
    print('publisher profile info display didchangedepcey ...........');
    // token = Provider.of<Auth>(context, listen: false).token;
    // isGetMeRunning = true;
    token = Provider.of<Auth>(context, listen: false).token;
    userProfile = Provider.of<PublisherProfileProvder>(context, listen: false)
        .getMe(token);
    super.didChangeDependencies();
    isGetMeRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    print('display info ........');
    return Consumer<Auth>(
      builder: (context, auth, child) => Container(
        child: FutureBuilder(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('snapshot data.......${snapshot.data}');

              return Container(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.rectangle,
                          ),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(headers: {
                              'Authorization': 'Bearer ${token}'
                            }, '${auth.getBaseUrl}/seller-profiles/cover-image/${snapshot.data!.cover_image}'),
                          ),
                        ),
                        Positioned(
                          // bottom: 0,
                          top: 180,
                          left: 5,
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(headers: {
                                'Authorization': 'Bearer ${token}'
                              }, '${auth.getBaseUrl}/seller-profiles/profile-image/${snapshot.data!.image}'),
                            ),
                            // child: Image(
                            //   fit: BoxFit.cover,
                            //   image: NetworkImage(headers: {
                            //     'Authorization': 'Bearer ${token}'
                            //   }, '${auth.getBaseUrl}/seller-profiles/profile-image/${snapshot.data!.image}'),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        '${snapshot.data!.name}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
            }
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/Vector.png'))),
                    Positioned(
                      // bottom: 0,
                      top: 180,
                      left: 5,
                      child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Image(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/Vector.png'))),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'user name',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
