import 'dart:async';
import 'dart:convert';

import 'package:ampedmedia_flutter/provider/tokenhandler.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_one_tap_sign_in/google_one_tap_sign_in.dart';

class Auth with ChangeNotifier {
  dynamic _token = null;
  DateTime? _expireyDate = DateTime.now();
  dynamic _refreshToken = null;
  dynamic autoTimer;
  bool isLogInWithFaceBook = false;
  bool isLogInWithGoogle = false;
  bool isFirstTime = true;
  //create google sign in object
  static final _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<bool> get getIsfirstTime async {
    print('isfirst time.....................................................');
    if (isFirstTime) {
      final prefs = await SharedPreferences.getInstance();
      isFirstTime = prefs.getBool("isFirstTime") ?? true;
      print(
          'isfirst time.....................................................$isFirstTime');
    }

    return isFirstTime;
  }

  String get getBaseUrl {
    return BackEndUrl.url;
  }

  void setIsfirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    isFirstTime = false;
    prefs.setBool("isFirstTime", false);
    isFirstTime = value;
  }

  bool get isAuth {
    return _token != null;
  }

  //returns the token
  dynamic get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  //facebook sign in
  Future<void> faceBookLogin() async {
    final baseUrll = BackEndUrl.url;

    final baseUrl = '$baseUrll/auth/googlePhone';
    print('.............................inside fb authentication');
    try {
      final result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'user_link', 'email'],
      );
      print(
          "${result.accessToken?.token}...........................accesstoken of fb inside fb login auth");

      final UserData userDataReponse =
          await TokenHandler.handleSignInWithFaceBook(
              result.accessToken?.token);
      // Define the data to be sent in the request parameters
      final data = {
        'firstName': userDataReponse.familyName,
        'lastName': userDataReponse.givenName,
        'email': userDataReponse.email,
      };
// Serialize the data as a query string
      final queryString = Uri(queryParameters: data).query;
// Use the query string in the request parameters to get accessToken from the backend
      var response = await http.post(Uri.parse(baseUrl + '?' + queryString));
      print(
          "${response.body}.................................responsedata from the backend");
      final AccessToken = json.decode(response.body);
      if (AccessToken['message'] != null) {
        throw '${AccessToken['message']}';
      }
      // isFirstTime = false;
      _token = AccessToken;
      _refreshToken = AccessToken;
      _expireyDate = DateTime.now().add(
        Duration(
          minutes: 15,
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      isFirstTime = false;
      prefs.setBool("isFirstTime", false);
      isLogInWithFaceBook = true;
      notifyListeners();
      final userData = json.encode(
        {
          'accessToken': _token,
          'refreshToken': _refreshToken,
          'expireyDate': _expireyDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      prefs.setBool("isLogInWithFaceBook", true);
    } catch (error) {
      print('$error..............................fb error');
      throw error;
    }
  }

  //google sign in
  Future<void> googleLogin() async {
    final baseUrl = BackEndUrl.url;

    dynamic data;
    final url = '$baseUrl/auth/verify_google_auth';

    try {
      var response = await GoogleOneTapSignIn.handleSignIn(
          webClientId:
              '518500154813-llcp76o4gdkpjuvdf2m6oav1ofi1mn8m.apps.googleusercontent.com');
      final idToken = response.data?.idToken;
      print(
          'idToken.....................................................................................${response.data?.idToken}');

      if (response.isTemporaryBlock) {
        throw "Request is temporarly blocked";
      }

      if (response.isCanceled) {
        throw "Request is canceled";
      }

      if (response.isFail) {
        throw "Requist is failed";
      }

      if (response.isOk) {
        data = {
          'idToken': response.data?.idToken,
        };
      }
      print(
          'before post mothod................................................................');
      final responseData = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({
            'idToken': response.data?.idToken,
          }));
      print(
          "responsedata body..........................................................${responseData.body}");
      final AccessToken = json.decode(responseData.body);
      if (AccessToken['message'] != null) {
        throw '${AccessToken['message']}';
      }
      print(
          'accestoken....................................................${AccessToken["access_token"]}');

      _token = AccessToken["access_token"];
      _refreshToken = AccessToken["access_token"];
      _expireyDate = DateTime.now().add(
        Duration(
          minutes: 15,
        ),
      );
      isLogInWithGoogle = true;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      isFirstTime = false;
      prefs.setBool("isFirstTime", false);
      final userData = json.encode(
        {
          'accessToken': _token,
          'refreshToken': _refreshToken,
          'expireyDate': _expireyDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      prefs.setBool("isLogInWithGoogle", true);
    } catch (error) {
      print(
          "$error......................................error from google signin");
      throw error;
    }
  }

//sign in with mobile number
  Future<void> signInWithMobileNumber(String idToken) async {
    final baseUrl = BackEndUrl.url;

    dynamic data;
    final url = '$baseUrl/auth/firebase';

    try {
      print(
          'before post mothod................................................................');
      final responseData = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken'
        },
      );
      print(
          "responsedata body..........................................................${responseData.body}");
      final AccessToken = json.decode(responseData.body);
      if (AccessToken['message'] != null) {
        throw '${AccessToken['message']}';
      }
      print(
          'accestoken....................................................${AccessToken["access_token"]}');
      _token = AccessToken["access_token"];
      print(
          '_token VALUE:............................................................................$_token');
      notifyListeners();
      _refreshToken = AccessToken["access_token"];
      _expireyDate = DateTime.now().add(
        Duration(
          minutes: 15,
        ),
      );
      // isLogInWithMobile = true;
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'accessToken': _token,
          'refreshToken': _refreshToken,
          'expireyDate': _expireyDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      prefs.setBool("isLogInWithGoogle", true);
      isFirstTime = false;
      prefs.setBool("isFirstTime", false);
    } catch (error) {
      print(
          "$error......................................error from mobilr number auth class");
      throw error;
    }
  }

  //sign in with email
  Future<void> signInWithEmail(Map<String, dynamic> signInUserData) async {
    final baseUrl = BackEndUrl.url;

    final url = '$baseUrl/auth/signin';
    print('url................................................$url');
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({
            "email": signInUserData['email'],
            "password": signInUserData['password'],
          }));
      print(
        'response..................................after http.post:' +
            response.body,
      );

      final extractedResponse = json.decode(response.body);
      if (extractedResponse['message'] != null) {
        throw '${extractedResponse['message']}';
      }
      // isFirstTime=false;
      _token = extractedResponse['accessToken'];
      print(
          '_token:...........................................................$_token');
      _refreshToken = extractedResponse['refreshToken'];
      _expireyDate = DateTime.now().add(
        Duration(
          minutes: 15,
        ),
      );
      // isFirstTime = false;
      notifyListeners();

      autoUpdateAccessToken();
      final prefs = await SharedPreferences.getInstance();
      isFirstTime = false;
      prefs.setBool("isFirstTime", false);
      final userData = json.encode(
        {
          'accessToken': _token,
          'refreshToken': _refreshToken,
          'expireyDate': _expireyDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      print('error:...............................................$error');
      if (error.toString().contains('No address associated with hostname')) {
        throw 'you don\'t have internet connection';
      }
      if (error
          .toString()
          .contains(' Connection closed before full header was received')) {
        throw 'your internet connection is weak';
      }

      throw error;
    }
  }

// signup with email
  Future<void> signUpWithEmail(Map<String, dynamic> signUpUserData) async {
    final baseUrl = BackEndUrl.url;

    final url = '$baseUrl/auth/signup';
    print('url.....................................................$url');
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({
            "username": signUpUserData['username'],
            "email": signUpUserData['email'],
            "phoneNo": signUpUserData["phoneNo"],
            "password": signUpUserData['password'],
            "passwordConfirm": signUpUserData['password']
          }));
      print(
        'response after http.post:..................................' +
            response.body,
      );
      final extractedResponse = json.decode(response.body);
      print(
          'rsponse body:........................................................$extractedResponse');
      if (extractedResponse['message'] != null) {
        throw '${extractedResponse['message']}';
      }
      // isFirstTime = false;
      _token = extractedResponse['accessToken'];
      _refreshToken = extractedResponse['refreshToken'];
      _expireyDate = DateTime.now().add(
        Duration(
          minutes: 15,
        ),
      );
      notifyListeners();
      autoUpdateAccessToken();
      final prefs = await SharedPreferences.getInstance();
      isFirstTime = false;
      prefs.setBool("isFirstTime", false);
      final userData = json.encode(
        {
          'accessToken': _token,
          'refreshToken': _refreshToken,
          'expireyDate': _expireyDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  //refresh token
  // void getNewAccessToken({bool isfrommain = false}) async {
  //   final baseUrl = BackEndUrl.url;
  //   final url = '$baseUrl/auth/refresh';

  //   final prefs = await SharedPreferences.getInstance();
  //   try {
  //     final extractedUserData =
  //         json.decode(prefs.getString('userData')) as Map<String, dynamic>;
  //     if (extractedUserData['accessToken'] != null) {
  //       _token = extractedUserData['accessToken'];
  //       _refreshToken = extractedUserData['refreshToken'];
  //       print(
  //           'auto generate token in 14 min........................................................$_token');
  //       if (isfrommain == false) {
  //         notifyListeners();
  //       }
  //       return;
  //     }
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${_refreshToken.toString()}',
  //       },
  //     );
  //     final extractedResponse = json.decode(response.body);
  //     if (extractedResponse['message'] != null) {
  //       print('${extractedResponse['message']}');
  //       return;
  //     }
  //     if (extractedResponse['message'] != null) {
  //       print('${extractedResponse['message']}');
  //       return;
  //     }
  //     print(
  //         'auto generate token in 14 min........................................................$_token');
  //     _token = extractedResponse['accessToken'];
  //     _refreshToken = extractedResponse['refreshToken'];
  //     _expireyDate = DateTime.now().add(
  //       Duration(
  //         minutes: 15,
  //       ),
  //     );
  //     if (isfrommain == false) {
  //       notifyListeners();
  //     }
  //     final userData = json.encode(
  //       {
  //         'accessToken': _token,
  //         'refreshToken': _refreshToken,
  //         'expireyDate': _expireyDate.toIso8601String(),
  //       },
  //     );
  //     prefs.setString('userData', userData);
  //   } catch (error) {
  //     throw error;
  //   }
  //   if (isfrommain = false) {
  //     notifyListeners();
  //   }
  // }

  //auto update access token
  void autoUpdateAccessToken() {
    if (autoTimer != null) {
      autoTimer.cancel();
    }
    final exactExpireTime = _expireyDate!.difference(DateTime.now()).inSeconds;

    autoTimer = Timer.periodic(Duration(seconds: exactExpireTime - 1), (timer) {
      // getNewAccessToken();
    });
  }

  void verifyAccount() {}

  //log out handler
  Future<void> logOut() async {
    print('log out');
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _expireyDate = null;
    _token = null;
    // await Auth.logOutFaceBook();
    // await Auth.googleLogOut();
    // _userId = null;
    // if (autoTimer != null) {
    //   autoTimer.cancel();
    //   autoTimer = null;
    // }
    // notifyListeners();

    notifyListeners();
  }

//out log in
  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    // isFirstTime = prefs.getBool("isFirstTime") ?? true;
    // notifyListeners();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    //auto login fb users
    // bool isLogInWithFaceBook = prefs.getBool("isLogInWithFaceBook") ?? false;
    // if (isLogInWithFaceBook) {
    //   final extractedUserData =
    //       json.decode(prefs.getString('userData')) as Map<String?, dynamic>;
    //   _token = extractedUserData['accessToken'];
    //   notifyListeners();
    //   return true;
    // }

    //auto login google users
    // bool isLogInWithGoogle = prefs.getBool("isLogInWithGoogle") ?? false;
    // if (isLogInWithGoogle) {
    //   final extractedUserData =
    //       json.decode(prefs.getString('userData')) as Map<String?, dynamic>;
    //   _token = extractedUserData['accessToken'];
    //   notifyListeners();
    //   return true;
    // }

    //auto log in non fb and non google users
    // final extractedUserData =
    //     json.decode(prefs.getString('userData')) as Map<String?, dynamic>;

    // final expiryDate = DateTime.parse(extractedUserData['expireyDate']);

    // if (expiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }
    // _userId = extractedUserData['userId'];
    // _token = extractedUserData['accessToken'];
    // _expireyDate = expiryDate;
    // _refreshToken = extractedUserData['refreshToken'];
    notifyListeners();
    // autoLogOuttimerset();
    autoUpdateAccessToken();
    return true;
  }

  //fb sign out
  static Future<void> logOutFaceBook() async {
    await FacebookAuth.instance.logOut();
  }

  //google sign out
  static Future<void> googleLogOut() async {
    await _googleSignIn.disconnect();
  }

  Future<int> updatePassword({required Map<String, dynamic> passData}) async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/profiles/update_password';
    int statusCode;
    try {
      // final response=http.patch(url.)
      final response = await http.patch(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode({
            "oldPassword": passData['oldPassword'],
            "newPassword": passData['newPassword'],
            "newPasswordConfirm": passData['newPasswordConfirm'],
          }));
      statusCode = response.statusCode;
    } catch (error) {
      throw Exception("$error");
    }
    return statusCode;
  }
}
