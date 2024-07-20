import 'dart:convert';

import 'package:ampedmedia_flutter/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportProvider with ChangeNotifier {
  Future<int> reportItem(String? token, Map<String, dynamic> reportData) async {
    if (token == null) {
      throw Exception('unauthorized');
    }
    print(reportData.entries);
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/reports';
    int statusCode;
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "report_type": reportData['report_type'],
            "report_desc": reportData['report_desc'],
            "material_id": reportData['material_id'],
            "channel_id": reportData['channel_id'],
          }));
      final extractedResponse = json.decode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('${extractedResponse['message']}');
      }
      return response.statusCode;
    } catch (error) {
      throw error;
    }
  }
}
