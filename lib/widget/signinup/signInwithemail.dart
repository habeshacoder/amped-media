//sign in with eamil
import 'dart:io';

import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/view/resetpassword/passwordreset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInWithEmailWidget extends StatefulWidget {
  const SignInWithEmailWidget({super.key});

  @override
  State<SignInWithEmailWidget> createState() => _SignInWithEmailWidgetState();
}

class _SignInWithEmailWidgetState extends State<SignInWithEmailWidget> {
  //sign up data for form values
  final Map<String, dynamic> signInWithEmailData = {
    "email": "",
    "password": "",
  };
  //
  var isSendingSignInRequestWithEmail = false;
  late bool _passwordVisible;
  //declare focus node
  var emailFocusNode;
  var passwordFocusNode;
  //initialize each field's key
  final emailFieldKey = GlobalKey<FormFieldState>();
  final passwordFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormState> _SignInWithEmailformKey = GlobalKey();

  void showalert(String message) {
    print('message:..................................................');
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
    super.initState();

    _passwordVisible = false;
    //init focusnodes
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    //add listner
    emailFocusNode.addListener(() {
      if (!(emailFocusNode.hasFocus)) {
        emailFieldKey.currentState!.validate();
      }
    });
    passwordFocusNode.addListener(() {
      if (!(passwordFocusNode.hasFocus)) {
        passwordFieldKey.currentState!.validate();
      }
    });
  }

  void togglePasswordVisibilty() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _SignInWithEmailformKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              maxLines: 1,
              decoration: const InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                suffixIcon: Icon(Icons.person),
                suffixIconColor: Colors.grey,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                filled: true,
                fillColor: Colors.white60,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0),
                ),
                // focusColor: Colors.grey,
                // labelText: 'Full Name',
                hintText: 'E-Mail',
              ),
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              key: emailFieldKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'email can not be empty';
                }
                if (!value.contains('@')) {
                  return 'please use @ in your email';
                }
                return null;
              },
              onSaved: (value) {
                signInWithEmailData['email'] = value!;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                suffixIcon: IconButton(
                    onPressed: togglePasswordVisibilty,
                    icon: _passwordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
                suffixIconColor: Colors.grey,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                filled: true,
                fillColor: Colors.white60,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0),
                ),
                // focusColor: Colors.grey,
                // labelText: 'Full Name',
                hintText: 'Password',
              ),
              obscureText: !_passwordVisible,
              focusNode: passwordFocusNode,
              key: passwordFieldKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'password can not be empty';
                }
                return null;
              },
              onSaved: (value) {
                signInWithEmailData['password'] = value;
              },
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFF00A19A),
                borderRadius: BorderRadius.circular(5),
              ),
              width: double.infinity,

              child: MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: isSendingSignInRequestWithEmail
                    ? CircularProgressIndicator()
                    : Text('Sign In'),
                onPressed: signInWithEmail,
              ),
              // child: Text('Sign Up'),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 13),
          //   width: double.infinity,
          //   child: Center(
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => ResetPassword(),
          //         ));
          //       },
          //       child: Text(
          //         'Reset Password',
          //         style: TextStyle(color: Color(0xFF00A19A)),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  //sign up method
  void signInWithEmail() async {
    print('email..............................................');
    if (!_SignInWithEmailformKey.currentState!.validate()) {
      return;
    }

    _SignInWithEmailformKey.currentState!.save();

    setState(() {
      isSendingSignInRequestWithEmail = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signInWithEmail(signInWithEmailData);
    } on HttpException catch (error) {
      print(error);
      print('.....................err');
      var errorMessage = 'authenticate faild';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'this email address is already in use';
      }
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'this is not a valid email';
      }
      if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'this password is too weak';
      }
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = ' could not find a user with that email';
      }
      if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'invalid password ';
      }
      showalert(errorMessage);
    } catch (error) {
      print(error);
      print('object');

      const errorMessage = 'could not authenticate you .please try again';
      showalert('$error');
    }
    setState(() {
      isSendingSignInRequestWithEmail = false;
    });
    // Navigator.pop(context);
    final checkifvalidated = Provider.of<Auth>(context, listen: false).isAuth;
    if (checkifvalidated) {
      Navigator.of(context).popAndPushNamed('/');
    }
  }
}
