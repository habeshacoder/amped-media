import 'package:ampedmedia_flutter/appstyles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserProfileDashboard extends StatefulWidget {
  static const routeName = '/UserProfileDashboard';

  const UserProfileDashboard({super.key});

  @override
  State<UserProfileDashboard> createState() => UserProfileDashboardState();
}

class UserProfileDashboardState extends State<UserProfileDashboard> {
  // late Future<List<Order>> orders;
  String _nearByDistanceValue = '10km';
  int selectedTopicIndex = 0;
  Future<void> _refreshOrders() async {
    setState(() {
      // orders = Provider.of<OrderService>(context, listen: false).fetchMyOrder();
    });
  }

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
    print('get mu order ...........');

    // orders = Provider.of<OrderService>(context, listen: false).fetchMyOrder();
    super.didChangeDependencies();
    print("after orders fetched............");
  }

  //dropdown for measurments
  List<DropdownMenuItem<String>> _nearByDistanceDropDowns() {
    List<String> nearByDistnances = ['10km', '20km', '13km'];
    return nearByDistnances!.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<Widget> topBarList = [
    Dashboard(),
    MyWishlist(),
    Library(),
    MyOrders(),
    Settings(),
  ];
  List<Widget> bodyList = [
    // AllWidget(),
    // ApprovedWidget(),
    // PendingWidget(),
    // RejectedWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            Colors.transparent, // Set the status bar color to transparent
      ),
    );
    // String fullName = "${currentUser!.firstName} ${currentUser.lastName}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P2pAppColors.lightgreen,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: P2pAppColors.normal,
            size: 31,
          ),
        ),
        title: Text(
          'Account Dashboard',
          style: TextStyle(
              // fontFamily: P2pAppFontsFamily.descriptionTexts.fontFamily,
              // fontSize: P2pFontSize.p2p18
              ),
        ),
      ),
      backgroundColor: P2pAppColors.grey,
      body: RefreshIndicator(
        onRefresh: _refreshOrders,
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      color: P2pAppColors.lightgreen,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: topBarList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedTopicIndex = index;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            color: selectedTopicIndex == index
                                ? Colors.white
                                : null,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: topBarList[index],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                // bodyList[selectedTopicIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteOrder(int? orderId) async {
    print('delete...............................');

    /// The commented line of code is calling the `Provider.of<OrderService>(context, listen: false)`
    /// method to access the `OrderService` provider and retrieve the status code. The `listen`
    /// parameter is set to `false`, indicating that the widget does not need to rebuild when the
    /// `OrderService` changes.
    //   try {
    //     // final statusCode = await Provider.of<OrderService>(context, listen: false)
    //     //     .deleteOrder(orderId);
    //     // if (statusCode == 204 || statusCode == 202) {
    //     //   ScaffoldMessenger.of(context).showSnackBar(
    //     //     SnackBar(
    //     //       content: Text(
    //     //         'Order item deleted successfully',
    //     //         style: TextStyle(color: P2pAppColors.yellow),
    //     //       ),
    //     //     ),
    //     //   );
    //       await _refreshOrders();

    //       //
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(
    //             'failed to delete order',
    //             style: TextStyle(color: Colors.red),
    //           ),
    //         ),
    //       );
    //       return;
    //     }
    //   } catch (error) {
    //     // showalert(error.toString());
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //           'failed to delete order',
    //           style: TextStyle(color: Colors.red),
    //         ),
    //       ),
    //     );
    //     return;
    //   }
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Icon(Icons.dashboard), Text('dashboard')],
    );
  }
}

class SellerProfiles extends StatelessWidget {
  const SellerProfiles({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Icon(Icons.person_2_rounded), Text('Seller Profiles')],
    );
  }
}

class MyWishlist extends StatelessWidget {
  const MyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.bookmark),
        Text('My Wishlist'),
      ],
    );
  }
}

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.library_add), // The first icon
          ],
        ),
        Text('Library')
      ],
    );
  }
}

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.shopping_basket), // The first icon
          ],
        ),
        Text('My Orders')
      ],
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.settings), // The first icon
          ],
        ),
        Text('Settings')
      ],
    );
  }
}
