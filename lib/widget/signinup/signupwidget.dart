import 'package:ampedmedia_flutter/widget/signinup/signupwithemailwidget.dart';
import 'package:flutter/material.dart';

enum AuthMode { email, mobilenumber }

class SignUpWidget extends StatefulWidget {
  final Function switchSignInSignUp;
  final SignMode;
  SignUpWidget({required this.switchSignInSignUp, required this.SignMode});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _isSignin = true;
  AuthMode _authMode = AuthMode.email;
  final _passwordController = TextEditingController();

  void _switchAuthMode(var authMode) {
    setState(() {
      _authMode = authMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  // color: Colors.red,
                  child: Center(
                      child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )),
                  // child: Text('Sign Up'),
                ),
                //signUpwithEmailWidget
                SignUpWithEmailWidget(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Already have an account?'),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () => widget.switchSignInSignUp(widget.SignMode),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xFF00A19A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
