import 'package:ampedmedia_flutter/dashboard.dart';
import 'package:ampedmedia_flutter/provider/onboadingprovider.dart';
import 'package:ampedmedia_flutter/widget/onboarding/audiobooksonboard.dart';
import 'package:ampedmedia_flutter/widget/onboarding/podcastsonboarding.dart';
import 'package:ampedmedia_flutter/widget/onboarding/publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnbordingView extends StatefulWidget {
  @override
  _OnbordingViewState createState() => _OnbordingViewState();
}

class _OnbordingViewState extends State<OnbordingView> {
  //
  //
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark, // dark text for status bar
        systemNavigationBarColor: Colors.white,
      ),
    );
    super.initState();
  }

//
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  late PageController _controller;
  List<Widget> onboardings = [
    publication(),
    AudioBooksOnBoarding(),
    PodcastsOnBoarding(),
  ];
  @override
  Widget build(BuildContext context) {
    //
    var appBar = AppBar();

    var appScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(top: appBar.preferredSize.height),
          width: appScreenWidth,
          child: Column(
            children: [
              Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //skip button
                    if (!(currentIndex == 2 || currentIndex == 3))
                      TextButton(
                        onPressed: () {
                          print(
                              'indside skip.......................$currentIndex');
                          if (currentIndex == 0) {
                            setState(() {
                              currentIndex += 2;
                            });
                          }
                          if (currentIndex == 1) {
                            setState(() {
                              currentIndex += 1;
                            });
                          }
                        },
                        child: Text(
                          'skip',
                          style: TextStyle(
                            fontFamily: 'OpenSnas',
                            color: Color(0xFFAFAFB1),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
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
                  child: onboardings[currentIndex],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 100,
                height: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingProvider.length, //3
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100, bottom: 100),
                width: double.infinity,
                child: Column(
                  children: [
                    //next button 0.16
                    if (!(currentIndex == 2))
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: TextButton(
                                onPressed: () {
                                  if (currentIndex < 2) {
                                    setState(() {
                                      currentIndex += 1;
                                    });
                                  }
                                },
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF00A19A),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    //get started buttton 0.2
                    if (currentIndex == 2)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF00A19A),
                        ),
                        margin:
                            EdgeInsets.only(bottom: 100, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool("isFirstTime", false);
                                Navigator.of(context)
                                    .pushNamed(DashBoard.routeName);
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(),
            ],
          )),
    ));
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      width: currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Color(0xFF00A19A) : Colors.grey,
      ),
    );
  }
}
