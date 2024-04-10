import 'package:ampedmedia_flutter/widget/signinup/signInwithemail.dart';
import 'package:flutter/material.dart';

enum AuthMode { email, mobilenumber }

class SignInWidget extends StatefulWidget {
  final Function switchSignInSignUp;
  final SignMode;
  SignInWidget({required this.switchSignInSignUp, required this.SignMode});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
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
                    'Welcome Again',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )),
                  // child: Text('Sign Up'),
                ),
                SignInWithEmailWidget(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

            width: double.infinity,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Not registered yet?'),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () => widget.switchSignInSignUp(widget.SignMode),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Create new account',
                      style: TextStyle(
                        color: Color(0xFF00A19A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
