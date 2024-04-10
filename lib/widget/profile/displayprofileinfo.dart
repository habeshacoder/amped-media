import 'package:ampedmedia_flutter/model/profile.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/readerprofileprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayProfileInfo extends StatefulWidget {
  const DisplayProfileInfo({super.key});

  @override
  State<DisplayProfileInfo> createState() => _DisplayProfileInfoState();
}

class _DisplayProfileInfoState extends State<DisplayProfileInfo> {
  bool isInit = true;
  bool isGetMeRunning = false;
  late Future<ProfileModel> userProfile;
  String? token;
  @override
  void didChangeDependencies() {
    print('profiledisppkayinfo...........');
    // token = Provider.of<Auth>(context, listen: false).token;
    // isGetMeRunning = true;
    token = Provider.of<Auth>(context, listen: false).token;
    userProfile =
        Provider.of<ProfileProvider>(context, listen: false).getMe(token);
    super.didChangeDependencies();
    isGetMeRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    print('display info ........');
    return Consumer<Auth>(
      builder: (context, auth, child) => Container(
        // height: 150,
        child: FutureBuilder(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                          fit: BoxFit.cover,
                          image: NetworkImage(headers: {
                            'Authorization': 'Bearer ${token}'
                          }, '${auth.getBaseUrl}/profiles/cover-image/${snapshot.data!.cover_image}'),
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
                            }, '${auth.getBaseUrl}/profiles/profile-image/${snapshot.data!.profile_image}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      '${snapshot.data!.first_name} ${snapshot.data!.last_name}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
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
