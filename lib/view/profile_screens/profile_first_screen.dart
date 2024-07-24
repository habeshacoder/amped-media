import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/view/profile_screens/about_us.dart';
import 'package:ampedmedia_flutter/view/createchannel/createChannel.dart';
import 'package:ampedmedia_flutter/view/creatematerial.dart/creatematerial.dart';
import 'package:ampedmedia_flutter/view/profile/edit_seller_profile.dart';
import 'package:ampedmedia_flutter/view/profile/edituserprofile.dart';
import 'package:ampedmedia_flutter/view/profile/chooseprofile.dart';
import 'package:ampedmedia_flutter/view/profile_screens/mydashboard.dart';
import 'package:ampedmedia_flutter/view/profile_screens/faq_screen.dart';
import 'package:ampedmedia_flutter/view/seller_profile_dashboard.dart';
import 'package:ampedmedia_flutter/view/signinup.dart';
import 'package:ampedmedia_flutter/view/userprofile_dashboard.dart';
import 'package:ampedmedia_flutter/widget/profile/displayprofileinfo.dart';
import 'package:ampedmedia_flutter/widget/profile/displaypublisherprofile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static final routeName = '/Profile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isInit = true;
  bool? isFetchingUserData;
  late Future<dynamic> userProfile;
  String? token;

  List<String> profileTypes = ['reader', 'publisher'];

  String selectedProfileType = '';

  @override
  void initState() {
    // TODO: implement initState
    selectedProfileType = profileTypes[0];
    super.initState();
  }

  //display error message to user
  void showalert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('an error occured'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('okay'),
            )
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    print('profiledisppkayinfo...........');
    // token = Provider.of<Auth>(context, listen: false).token;
    // isGetMeRunning = true;
    token = Provider.of<Auth>(context, listen: false).token;
    super.didChangeDependencies();
  }

  DateTime _selectedDateofBirth = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xF0F9F8),
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
    );
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              if (selectedProfileType == 'reader') DisplayProfileInfo(),
              if (selectedProfileType == 'publisher')
                DisplayPublisherProfileInfo(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      onTap: null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text('Switch Account'),
                        Expanded(
                          child: ListTile(
                            title: Text('Switch Account'),
                            onTap: null,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedProfileType,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedProfileType = newValue;
                              });
                            }
                          },
                          items: profileTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    if (selectedProfileType == 'publisher')
                      // ListTile(
                      //   title: Text('Account Dashboard'),
                      //   onTap: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => SellerDashBoardScreen(),
                      //     ));
                      //   },
                      // ),
                      if (selectedProfileType == 'reader')
                        // ListTile(
                        //   title: Text('Account Dashboard'),
                        //   onTap: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => UserProfileDashboard(),
                        //     ));
                        //   },
                        // ),
                        ListTile(
                          title: Text('Account Information'),
                          onTap: () {
                            if (selectedProfileType == 'reader') {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditUserProfile(),
                              ));
                            }
                            if (selectedProfileType == 'publisher') {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditSellerProfile(),
                              ));
                            }
                          },
                        ),
                    // ListTile(
                    //   title: Text('Privacy Settings'),
                    //   onTap: null,
                    // ),

                    // ListTile(
                    //   title: Text('Sound Settings'),
                    //   onTap: null,
                    // ),
                    ListTile(
                      title: Text('Create profile'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChooseProfile(),
                        ));
                      },
                    ),
                    ListTile(
                      title: Text('Dashboard'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Mydashboard(),
                        ));
                      },
                    ),
                    ListTile(
                      title: Text('Sign In'),
                      onTap: () {
                        Navigator.of(context).pushNamed(SignInOut.routeName);
                      },
                    ),
                    if (selectedProfileType == 'publisher')
                      ListTile(
                        title: Text('create channel'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateNewChannel(),
                          ));
                        },
                      ),
                    if (selectedProfileType == 'publisher')
                      ListTile(
                        title: Text('Create Material'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateMaterial(),
                          ));
                        },
                      ),
                    ListTile(
                      title: Text('About Us'),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ))
                      },
                    ),

                    ListTile(
                      title: Text('FAQ'),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FaqScreen(),
                        ))
                      },
                    ),
                    ListTile(
                      title: Text('Log Out'),
                      onTap: () async {
                        // Navigator.pop(context);
                        print('after pop in drawer in the log out');
                        await Provider.of<Auth>(context, listen: false)
                            .logOut();

                        Navigator.of(context).pushReplacementNamed('/');
                        print('after pop in drawer in the log out');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
