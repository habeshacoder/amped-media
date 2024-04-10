import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfileTypeDeterminer with ChangeNotifier {
  Future<dynamic> getProfileType(String? token) async {
    try {
      if (token == null) {
        print('token is null to do getme method...........');
        throw Exception('unauthorized access');
      }

      final baseUrl = BackEndUrl.url;
      final url = '$baseUrl/profiles/me';

      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );
      final extractedResponse = json.decode(response.body);
      print('status code${response.statusCode}');
      print('status code${extractedResponse['message']}');

      if ((response.statusCode == 200 &&
              extractedResponse['message'] == null) ||
          (response.statusCode == 201 &&
              extractedResponse['message'] == null)) {
        print('first name prof determiner:${extractedResponse['first_name']}');
        print('check............');
        return '${extractedResponse['first_name']}';
      }
//no reader
      if (extractedResponse['message']
          .toString()
          .contains('No profile found')) {
        return extractedResponse["message"];
      }

      ;
    } catch (e) {
      throw e;
    }
  }
}
