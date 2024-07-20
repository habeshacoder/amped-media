import 'package:ampedmedia_flutter/view/dashbaordscreens/explore.dart';
import 'package:ampedmedia_flutter/view/dashbaordscreens/home.dart';
import 'package:ampedmedia_flutter/view/profile_screens/profile_first_screen.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  static final routeName = '/DashBoard';
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int bottomNavigationBarCurrentIndex = 0;
  List<Widget> DashBoardPagesList = [
    Home(),
    Explore(),
    // Library(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: DashBoardPagesList,
        index: bottomNavigationBarCurrentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        // showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: bottomNavigationBarCurrentIndex,
        onTap: (index) {
          setState(() {
            bottomNavigationBarCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/Home.png')),
            backgroundColor: Color(0xCFEEED),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/Search.png')),
            backgroundColor: Color(0xCFEEED),
            label: "Explore",
          ),
          // BottomNavigationBarItem(
          //   icon: Image(image: AssetImage('assets/images/Library.png')),
          //   backgroundColor: Color(0xCFEEED),
          //   label: "Library",
          // ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/Profile.png')),
            backgroundColor: Color(0xCFEEED),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
