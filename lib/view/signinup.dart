import 'dart:io';

import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/view/loginsplashscreen.dart';
import 'package:ampedmedia_flutter/view/profile/chooseprofile.dart';
import 'package:ampedmedia_flutter/widget/signinup/signinwidget.dart';
import 'package:ampedmedia_flutter/widget/signinup/signupwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum SignMode { signin, signup }

class SignInOut extends StatefulWidget {
  static final routeName = '/signinout';
  const SignInOut({super.key});

  @override
  State<SignInOut> createState() => _SignInOutState();
}

class _SignInOutState extends State<SignInOut> {
  bool _isSignin = true;
  bool isSendingSignInRequestWithFaceBook = false;
  bool isSendingSignInRequestWithGoogle = false;
  void switchSignInandUp(SignMode signmode) {
    print('object........................................................');
    if (signmode == SignMode.signin) {
      setState(() {
        _isSignin = true;
      });
    }
    if (signmode == SignMode.signup) {
      setState(() {
        _isSignin = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent, // transparent status bar
              statusBarIconBrightness:
                  Brightness.dark, // dark text for status bar
              systemNavigationBarColor: Colors.white,
            ),
          );
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black54,
        ),
      ),
    );
    var appScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: isSendingSignInRequestWithFaceBook
          ? null
          : isSendingSignInRequestWithGoogle
              ? null
              : appBar,
      body: isSendingSignInRequestWithFaceBook
          ? LogInSplashScreen()
          : isSendingSignInRequestWithGoogle
              ? LogInSplashScreen()
              : Container(
                  // color: Colors.grey[300],
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //image 0.3
                        Center(
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: Image(
                                width: double.infinity,
                                image: AssetImage(
                                    'assets/images/ampedmedialogo.png')),
                          ),
                        ),
                        if (_isSignin == false)
                          Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: SignUpWidget(
                                  switchSignInSignUp: switchSignInandUp,
                                  SignMode: SignMode.signin)),
                        if (_isSignin == true)
                          Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: SignInWidget(
                                  switchSignInSignUp: switchSignInandUp,
                                  SignMode: SignMode.signup)),
                        // Center(child: Text('or')),
                        // Center(
                        //   child: Container(
                        //     margin: EdgeInsets.only(bottom: 5, top: 5),
                        //     child: Text('Continue with '),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 100),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       Card(
                        //         elevation: 3,
                        //         child: Container(
                        //           height: 40,
                        //           width: 155,
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           child: TextButton.icon(
                        //               onPressed: signUpWithGOOGLE,
                        //               icon: Image(
                        //                   image: AssetImage(
                        //                       'assets/images/Google.png')),
                        //               label: Text('Google')),
                        //         ),
                        //       ),
                        //       Card(
                        //         elevation: 3,
                        //         child: Container(
                        //           height: 40,
                        //           width: 155,
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           child: TextButton.icon(
                        //               onPressed: signUpWithFaceBook,
                        //               icon: Image(
                        //                   image: AssetImage(
                        //                       'assets/images/Facebooklogo2019.png')),
                        //               label: Text('Facebook')),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
    );
  }

//sign up with facebook
  void signUpWithFaceBook() async {
    setState(() {
      isSendingSignInRequestWithFaceBook = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).faceBookLogin();
    } on HttpException catch (error) {
      print(error);
      print('.....................err');

      var errorMessage = 'authenticate faild';

      showalert(errorMessage);
    } catch (error) {
      print(error);
      showalert('$error');
    }
    setState(() {
      isSendingSignInRequestWithFaceBook = false;
    });
    // Navigator.pop(context);
    final checkifvalidated = Provider.of<Auth>(context, listen: false).isAuth;
    if (checkifvalidated) {
      Navigator.of(context).pushNamed(ChooseProfile.routeName);
    }
  }

//google sign up
  void signUpWithGOOGLE() async {
    setState(() {
      isSendingSignInRequestWithGoogle = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).googleLogin();
    } on HttpException catch (error) {
      print(error);
      print('.....................err');

      var errorMessage = 'authenticate faild';

      showalert(errorMessage);
    } catch (error) {
      print(error);
      showalert('$error');
    }
    setState(() {
      isSendingSignInRequestWithGoogle = false;
    });
    // Navigator.pop(context);
    final checkifvalidated = Provider.of<Auth>(context, listen: false).isAuth;
    if (checkifvalidated) {
      Navigator.of(context).pushNamed(ChooseProfile.routeName);
    }
  }

//log out fb
  void logoutFaceBook() async {
    await Auth.logOutFaceBook();
  }

//goolge log out
  void logoutGoole() async {
    final response = await Auth.googleLogOut();
  }
}
