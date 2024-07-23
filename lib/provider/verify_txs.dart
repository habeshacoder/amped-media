import 'dart:convert';

import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifyTXSProvider with ChangeNotifier {
  Future<dynamic> verifyPayment(String? token) async {
    if (token == null) {
      throw Exception('unauthorized');
    }
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material-purchase/verify';
    // int statusCode;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final extractedResponse = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return extractedResponse;
      } else {
        throw Exception('${extractedResponse['message']}');
      }
    } catch (error) {
      throw error;
    }
  }
}
