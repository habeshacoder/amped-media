import 'package:ampedmedia_flutter/view/profile/createpublisher.dart';
import 'package:ampedmedia_flutter/view/profile/createprofile.dart';
import 'package:flutter/material.dart';

class ChooseProfile extends StatefulWidget {
  static final routeName = '/chooseprofile';
  const ChooseProfile({super.key});

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Color(0xF0F9F8),
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black54,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What describes you?',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              softWrap: true,
              'Select what describes you, we show information as your preference.',
              style: TextStyle(fontSize: 12),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                    'Reader?',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateProfile.routeName);
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                    'Publisher?',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreatePublisherProfile(),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
