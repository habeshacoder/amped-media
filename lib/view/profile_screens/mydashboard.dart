import 'package:ampedmedia_flutter/view/profile_screens/my_materials.dart';
import 'package:ampedmedia_flutter/view/profile_screens/paid_materials.dart';
import 'package:flutter/material.dart';

class Mydashboard extends StatefulWidget {
  const Mydashboard({super.key});

  @override
  State<Mydashboard> createState() => _MydashboardState();
}

class _MydashboardState extends State<Mydashboard> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String? token;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onSearch(String searchText) {
    setState(() {
      isSearching = true;
    });
  }

  void clearSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Materials'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            PaidMaterial(),
            SizedBox(
              height: 4,
            ),
            MyMaterial(),
          ],
        ),
      ),
    );
  }
}
