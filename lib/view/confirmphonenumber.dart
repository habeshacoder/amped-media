import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/view/loginsplashscreen.dart';
import 'package:ampedmedia_flutter/view/profile/chooseprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmPhoneNumber extends StatefulWidget {
  final String phone;
  ConfirmPhoneNumber(this.phone);
  @override
  _ConfirmPhoneNumberState createState() => _ConfirmPhoneNumberState();
}

class _ConfirmPhoneNumberState extends State<ConfirmPhoneNumber> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode = '';
  final TextEditingController _smsController = TextEditingController();
  bool isSendingSignInRequestWithPhoneNumber = false;
  bool isverfyphonenumber = false;
  int _secondsRemaining = 120;

//start a count down for sms code
  void startCountdownTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          // stop the timer when it reaches zero
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Text(
        'Verify Your Phone Number',
        style: TextStyle(color: Colors.black),
      ),
    );
    return Scaffold(
      key: _scaffoldkey,
      appBar: isverfyphonenumber ? null : appBar,
      body: isverfyphonenumber
          ? LogInSplashScreen()
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Verify +251-${widget.phone}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                        textAlign: TextAlign.justify,
                        'We sent a six digit code to your phone number. Please enter the code in the next 120 seconds')),
                SizedBox(
                  height: 50,
                ),
                //input filed for the users to enter the sms cod sent to there phone
                Container(
                  child: PinCodeTextField(
                    keyboardType: TextInputType.phone,
                    enableActiveFill: true,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    pinTheme: PinTheme.defaults(
                        borderWidth: 1,
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.white70,
                        fieldWidth: 40,
                        shape: PinCodeFieldShape.box),
                    appContext: context,
                    length: 6, // number of digits for the SMS code
                    controller: _smsController,
                    onChanged: (String value) {
                      // move to next field when user enters a digit in current field
                      if (value.length == 7 - 1)
                        FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //submit button for checking the sms code of the user
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF00A19A),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: double.infinity,

                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: isSendingSignInRequestWithPhoneNumber
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Confirm Code'),
                      onPressed: confirmCode,
                    ),
                    // child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
    );
  }

//check the user entered sms code against the firebase
  void confirmCode() async {
    print(
        '..................................................begin  confrimcode');
    setState(() {
      isSendingSignInRequestWithPhoneNumber = true;
    });
    try {
      print(
          '_verificationCode........................................................$_verificationCode');
      print(
          '_smsController.text.trim()........................................................${_smsController.text.trim()}');
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode,
              smsCode: _smsController.text.trim()))
          .then((value) async {
        final getUserIdToken = await value.user?.getIdToken(true);
        print(
            'getUserIdToken.........................................................$getUserIdToken');
        await Provider.of<Auth>(context, listen: false)
            .signInWithMobileNumber(getUserIdToken!);
      });
    } catch (e) {
      print(
          'error............................................................$e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isSendingSignInRequestWithPhoneNumber = false;
    });
    final checkifvalidated = Provider.of<Auth>(context, listen: false).isAuth;
    if (checkifvalidated) {
      Navigator.of(context).pushNamed(ChooseProfile.routeName);
    }
  }

//send a sms code for the phone number
  _verifyPhone() async {
    isverfyphonenumber = true;
    print(
        'begin _verfyphone.........................................................................');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+251${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print(
                  '${value}.........................................................................usercredential');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            print(
                '_verificationCode from verify phonenumber........................................................$verficationID');
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
    isverfyphonenumber = false;
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
