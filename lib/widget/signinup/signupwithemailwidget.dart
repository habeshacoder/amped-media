import 'dart:io';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/view/profile/chooseprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpWithEmailWidget extends StatefulWidget {
  const SignUpWithEmailWidget({super.key});

  @override
  State<SignUpWithEmailWidget> createState() => _SignUpWithEmailWidgetState();
}

class _SignUpWithEmailWidgetState extends State<SignUpWithEmailWidget> {
  //sign up data for form values
  final Map<String, dynamic> signUpWithEmailData = {
    "username": "",
    "email": "",
    "phoneNo": "",
    "password": "",
  };
  //
  var isSendingSignUpRequestWithEmail = false;
  var isChecked = false;
  var isCheckedErrorMessage = false;
  late bool _passwordVisible;
  late bool confirmPasswordVisibilty;
  //declare focus node
  var fullNameFocusNode;
  var emailFocusNode;
  var passwordFocusNode;
  var confirmPasswordFocusNode;
  var MobileNumberFocusNode;
  TextEditingController phoneNumberController = TextEditingController();
  final MobileNumberFieldKey = GlobalKey<FormFieldState>();

  //initialize each field's key
  final fullNameFieldKey = GlobalKey<FormFieldState>();
  final emailFieldKey = GlobalKey<FormFieldState>();
  final passwordFieldKey = GlobalKey<FormFieldState>();
  final confirmPasswordFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormState> _SignUpWithEmailformKey = GlobalKey();
  //controller
  final passwordController = TextEditingController();

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
    super.initState();

    _passwordVisible = false;
    confirmPasswordVisibilty = false;
    //init focusnodes
    fullNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    MobileNumberFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    //add listner
    fullNameFocusNode.addListener(() {
      if (!(fullNameFocusNode.hasFocus)) {
        fullNameFieldKey.currentState!.validate();
      }
    });
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
    confirmPasswordFocusNode.addListener(() {
      if (!(confirmPasswordFocusNode.hasFocus)) {
        confirmPasswordFieldKey.currentState!.validate();
      }
    });
    MobileNumberFocusNode.addListener(() {
      if (!(MobileNumberFocusNode.hasFocus)) {
        MobileNumberFieldKey.currentState!.validate();
      }
    });
  }

  void togglePasswordVisibilty() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void toggleConfirmPasswordVisibilty() {
    setState(() {
      confirmPasswordVisibilty = !confirmPasswordVisibilty;
    });
  }

  @override
  void dispose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _SignUpWithEmailformKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        suffixIcon: Icon(Icons.person),
                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 7),
                        filled: true,
                        fillColor: Colors.white60,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0),
                        ),
                        hintText: 'Full Name',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      focusNode: fullNameFocusNode,
                      key: fullNameFieldKey,
                      validator: SignUpFormHandler.fullNameValidator,
                      onSaved: (newValue) {
                        signUpWithEmailData["username"] = newValue;
                      },
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        suffixIcon: Icon(Icons.email),
                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 7),
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
                      // controller: _emailController,
                      validator: SignUpFormHandler.emailValidator,
                      focusNode: emailFocusNode,
                      key: emailFieldKey,

                      onSaved: (newValue) {
                        signUpWithEmailData["email"] = newValue;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                    child: IntlPhoneField(
                      initialCountryCode: 'ET',
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        suffixIcon: Icon(Icons.phone),
                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 7),
                        filled: true,
                        fillColor: Colors.white60,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0),
                        ),
                        focusColor: Colors.grey,
                        // labelText: 'Full Name',
                        hintText: 'Mobile Number',
                      ),
                      key: MobileNumberFieldKey,
                      focusNode: MobileNumberFocusNode,
                      controller: phoneNumberController,
                      //  validator: _validatePhoneInput,
                      onSaved: (value) {
                        signUpWithEmailData["phoneNo"] =
                            "251" + phoneNumberController.text;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      // maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(overflow: TextOverflow.clip),
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
                            EdgeInsets.symmetric(vertical: 16, horizontal: 7),
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
                      controller: passwordController,
                      validator: SignUpFormHandler.passwordValidator,
                      focusNode: passwordFocusNode,
                      key: passwordFieldKey,
                      onSaved: (newValue) {
                        signUpWithEmailData["password"] = newValue;
                      },
                    ),
                  ),
                  Text(
                      textAlign: TextAlign.justify,
                      'password length must be minimum of four and maximum of 20.And include one upercase, lowercase, number and character'),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        suffixIcon: IconButton(
                            onPressed: toggleConfirmPasswordVisibilty,
                            icon: confirmPasswordVisibilty
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),

                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 7),
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
                        hintText: 'confirm Password',
                      ),
                      obscureText: !confirmPasswordVisibilty,
                      focusNode: confirmPasswordFocusNode,
                      key: confirmPasswordFieldKey,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your password';
                        }
                        if (value == null) {
                          return 'Passwords do not match!';
                        }
                        if (value != passwordController.text) {
                          return 'passwords don\'t match';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Checkbox(
                  splashRadius: 2,
                  checkColor: Colors.black,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return null;
                  }),
                  value: isChecked,
                  // shape: ,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child:
                      Text('I agree to terms of services and privacy policy'),
                ),
              ],
            ),
          ),
          if (isCheckedErrorMessage)
            Text(
              'please mark the check box',
              style: TextStyle(color: Colors.red),
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
                child: isSendingSignUpRequestWithEmail
                    ? CircularProgressIndicator()
                    : Text('SIGN UP'),
                onPressed: signUpWithEmail,
              ),
              // child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }

  //sign up method
  void signUpWithEmail() async {
    print('phone:///////:' + signUpWithEmailData["phoneNo"]);
    if (!_SignUpWithEmailformKey.currentState!.validate()) {
      return;
    }
    if (isChecked == false) {
      setState(() {
        isCheckedErrorMessage = true;
      });
    }
    if (isChecked == true) {
      setState(() {
        isCheckedErrorMessage = false;
      });
    }

    _SignUpWithEmailformKey.currentState!.save();

    setState(() {
      isSendingSignUpRequestWithEmail = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUpWithEmail(signUpWithEmailData);
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
      isSendingSignUpRequestWithEmail = false;
    });
    final checkifvalidated = Provider.of<Auth>(context, listen: false).isAuth;
    if (checkifvalidated) {
      Navigator.of(context).pushNamed(ChooseProfile.routeName);
    }
  }
}
