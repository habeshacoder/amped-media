import 'package:flutter/material.dart';

class TopScrolls extends StatefulWidget {
  static final routeName = '/TopScrolls';
  const TopScrolls({super.key});

  @override
  State<TopScrolls> createState() => TopScrollsState();
}

class TopScrollsState extends State<TopScrolls> {
  int currentIndex = 0;
  List<Widget> containers = [
    Container(
      margin: EdgeInsets.only(left: 10, right: 16),
      height: 192,
      width: 340,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image(
          fit: BoxFit.contain, image: AssetImage('assets/images/Books.png')),
    ),
    Container(
      margin: EdgeInsets.only(left: 10, right: 16),
      height: 192,
      width: 340,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'AudioBooks',
          style: TextStyle(fontSize: 34),
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 10, right: 16),
      height: 192,
      width: 340,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Podcasts',
          style: TextStyle(fontSize: 34),
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    int listviewindex = 0;
    return Scaffold(
        body: Container(
      height: 230,
      // color: Colors.red,
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 19, bottom: 9),
              // color: Colors.green,
              height: 192,
              child: GestureDetector(
                  onHorizontalDragEnd: (dragDetail) {
                    if (dragDetail.velocity.pixelsPerSecond.dx < 1 &&
                        currentIndex < 2) {
                      setState(() {
                        currentIndex += 1;
                      });
                      print("left");
                    }
                    if (dragDetail.velocity.pixelsPerSecond.dx > 1 &&
                        currentIndex > 0) {
                      setState(() {
                        currentIndex -= 1;
                      });

                      print("RIGHT");
                    }
                  },
                  child: containers[currentIndex]),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => buildDot(index, context),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Color(0xFF00A19A) : Colors.grey,
      ),
    );
  }
}
