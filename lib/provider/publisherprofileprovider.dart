import 'dart:convert';
import 'dart:io';
import 'package:ampedmedia_flutter/model/publisherprofilemodel.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PublisherProfileProvder with ChangeNotifier {
  List<PublisherProfileModel> userProfile = [];
  dynamic loadedImageUrl;
  int? sellerProfile_id;

  List<PublisherProfileModel> get getUserProfile {
    return userProfile;
  }

  dynamic get getLoadedImageUrl {
    return loadedImageUrl;
  }

  String get getBaseUrl {
    return BackEndUrl.url;
  }

  // create seller profile
  Future<bool?> createSellerProfile(
      Map<String, dynamic> profileData, String token) async {
    bool? Iscontinue;
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/seller-profiles';
    File profileImage = profileData["profile"];
    File coverImage = profileData["cover"];

    try {
      final formDataRequest = http.MultipartRequest('POST', Uri.parse(url));
      final profileImageMultipart = http.MultipartFile(
        'image',
        profileImage.readAsBytes().asStream(),
        profileImage.lengthSync(),
        filename: profileImage.path.split('/').last,
      );
      final coverMultipart = http.MultipartFile(
        'cover',
        coverImage.readAsBytes().asStream(),
        coverImage.lengthSync(),
        filename: coverImage.path.split('/').last,
      );
      formDataRequest.files.add(profileImageMultipart);
      formDataRequest.files.add(coverMultipart);
      formDataRequest.fields['name'] = profileData["name"];
      formDataRequest.fields['description'] = profileData["description"];
      formDataRequest.fields['sex'] = profileData["sex"];
      formDataRequest.fields['date_of_birth'] =
          profileData["dateOfBirth"].toString();
      formDataRequest.headers['Authorization'] = 'Bearer $token';
      //send to back end
      final response = await formDataRequest.send();
      final responseBody = await response.stream.transform(utf8.decoder).join();
      final responseBodyDecoded = jsonDecode(responseBody);
      print('response:................................${responseBody}');
      //check response
      final checkresponsebody = jsonDecode(responseBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Iscontinue = true;
      } else {
        throw 'faild to create seller profile';
      }
    } catch (error) {
      throw error;
    }
    return Iscontinue;
  }

  //get profile information
  Future<PublisherProfileModel> getMe(String? token) async {
    // final auth = Auth();
    if (token == null) {
      print('token is null to do getme method...........');
      throw Exception('unauthorized access');
    }

    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/seller-profiles';
    print('token getme..................................:${token}');

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
    );
    print('respon body:...' + response.body);
    print('statuc code.....${response.statusCode}');
    final extractedResponse = json.decode(response.body);
    print('extracted ${extractedResponse}');
    print('after http.post called ...............${extractedResponse[0]}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('inside check.....');
      throw Exception('${extractedResponse['message']}');
    }

    print('after http.post called ...............${extractedResponse[0]}');
    print('sample here');

    final profileModel = PublisherProfileModel(
      id: extractedResponse[0]['id'],
      user_id: extractedResponse[0]['user_id'],
      name: extractedResponse[0]['name'],
      description: extractedResponse[0]['description'],
      sex: extractedResponse[0]['sex'],
      date_of_birth: extractedResponse[0]['date_of_birth'],
      image: extractedResponse[0]['image'],
      cover_image: extractedResponse[0]['cover_image'],
      created_at: extractedResponse[0]['created_at'],
      updated_at: extractedResponse[0]['updated_at'],
    );
    userProfile.add(profileModel);
    notifyListeners();
    return PublisherProfileModel.fromJson(extractedResponse[0]);
  }
}
