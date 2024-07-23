import 'dart:convert';

import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuyProvider with ChangeNotifier {
  Future<dynamic> sendPayment(
      String? token, Map<String, dynamic> paymentData) async {
    if (token == null) {
      throw Exception('unauthorized');
    }
    print(paymentData.entries);
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material-purchase/request_checkout';
    // int statusCode;
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(paymentData));
      final extractedResponse = json.decode(response.body);
      print(extractedResponse);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return extractedResponse['data']['checkout_url'];
      } else {
        throw Exception('${extractedResponse['message']}');
      }
    } catch (error) {
      throw error;
    }
  }
}
