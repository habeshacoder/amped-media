import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData {
  final String givenName;
  final String familyName;
  final String email;
  final bool isVerified;
  final String provider;
  UserData({
    required this.givenName,
    required this.familyName,
    required this.email,
    required this.isVerified,
    required this.provider,
  });
}

class TokenHandler with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<UserData> handleSignInWithFaceBook(accessToken) async {
    print('................................................inside profile handler');
    final fields = 'first_name,last_name,email,name';
    print('$accessToken......................................');
    final response = await http.get(Uri.parse(
        'https://graph.facebook.com/me?fields=$fields&access_token=$accessToken'));

    final userData = jsonDecode(response.body);
    print('${response.body}.....................inside userprofile data');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final UserData userData = UserData(
          givenName: responseBody["first_name"],
          familyName: responseBody["last_name"],
          email: responseBody["email"],
          isVerified: true,
          provider: "facebook");
      print(userData.email);
      print(userData.familyName);
      print(userData.givenName);
      print(userData.provider);
      print(userData.isVerified);
      
      return userData;
    } else {
      throw Exception('Failed to load connections with google authentication');
    }
  }

  static Future<UserData> handleSignInWithGoogle(access_token) async {
    print('inside profile handler');
    // final String _baseUrl = 'https://people.googleapis.com/v1';
    final String _baseUrl =
        'https://people.googleapis.com/v1/people/me?personFields=names,emailAddresses,addresses,birthdays,genders,phoneNumbers,photos';
    // final String _apiPath = '/people/me/connections';
    final Map<String, String> _headers = {
      'Authorization': 'Bearer $access_token',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(_baseUrl), headers: _headers);
    print('${response.body}.....................inside userprofile data');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final email = responseBody["emailAddresses"][0]["value"];
      print("$email.......................email");
      final UserData userData = UserData(
          givenName: responseBody["names"][0]["givenName"],
          familyName: responseBody["names"][0]["familyName"],
          email: responseBody["emailAddresses"][0]["value"],
          isVerified: responseBody["emailAddresses"][0]["metadata"]["verified"],
          provider: "google");
      print(userData.email);
      print(userData.familyName);
      print(userData.givenName);
      print(userData.provider);
      print(userData.isVerified);
      return userData;
    } else {
      throw Exception('Failed to load connections with google authentication');
    }
  }
}
