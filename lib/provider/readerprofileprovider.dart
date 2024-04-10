import 'dart:convert';
import 'dart:io';
import 'package:ampedmedia_flutter/model/profile.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  List<ProfileModel> userProfile = [];

  String get getBaseUrl {
    return BackEndUrl.url;
  }

  // create profile
  Future<bool?> createProfile(
      Map<String, dynamic> profileData, String token) async {
    bool Iscontinue = false;
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/profiles';
    File profileImage = profileData["profileImage"];
    File coverImage = profileData["cover"];
    try {
      final formDataRequest = http.MultipartRequest('POST', Uri.parse(url));
      final profileImageMultipart = http.MultipartFile(
        'profile',
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
      formDataRequest.fields['first_name'] = profileData["firstName"];
      formDataRequest.fields['last_name'] = profileData["LastName"];
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
      if (checkresponsebody['message']
          .toString()
          .contains('User Profile Created Successfully')) {
        Iscontinue = true;
      } else {
        throw 'faild to create profile';
      }
    } catch (error) {
      throw error;
    }
    return Iscontinue;
  }

  Future<bool?> UpdateProfileCover(
      Map<String, dynamic> profileData, String token) async {
    bool Iscontinue = false;
    ProfileModel user = await getMe(token);

    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/profiles/cover_imege/${user.id}';
    File coverImage = profileData["cover"];
    try {
      final formDataRequest = http.MultipartRequest('PATCH', Uri.parse(url));

      final coverMultipart = http.MultipartFile(
        'cover',
        coverImage.readAsBytes().asStream(),
        coverImage.lengthSync(),
        filename: coverImage.path.split('/').last,
      );
      formDataRequest.files.add(coverMultipart);
      formDataRequest.headers['Authorization'] = 'Bearer $token';
      //send to back end
      final response = await formDataRequest.send();
      if (response.statusCode == 200) {
        Iscontinue = true;
      } else {
        throw 'faild to update image';
      }
    } catch (error) {
      throw error;
    }
    return Iscontinue;
  }

  // create profile
  Future<bool?> updateProfileImage(
      Map<String, dynamic> profileData, String token) async {
    bool Iscontinue = false;
    ProfileModel user = await getMe(token);
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/profiles/profile_image/${user.id}';
    File profileImage = profileData["profileImage"];
    try {
      final formDataRequest = http.MultipartRequest('PATCH', Uri.parse(url));
      final profileImageMultipart = http.MultipartFile(
        'profile',
        profileImage.readAsBytes().asStream(),
        profileImage.lengthSync(),
        filename: profileImage.path.split('/').last,
      );
      formDataRequest.files.add(profileImageMultipart);
      formDataRequest.headers['Authorization'] = 'Bearer $token';
      final response = await formDataRequest.send();

      if (response.statusCode == 200) {
        Iscontinue = true;
      } else {
        throw 'faild to update image';
      }
    } catch (error) {
      throw error;
    }
    return Iscontinue;
  }

  //get profile information
  Future<ProfileModel> getMe(String? token) async {
    if (token == null) {
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
    print('respon http.post:...' + response.body);

    final extractedResponse = json.decode(response.body);
    print('after http.post called ...............${extractedResponse}');
    if (extractedResponse['message'] != null || response.statusCode != 200) {
      throw Exception('${extractedResponse['message']}');
    }

    return ProfileModel.fromJson(extractedResponse);
  }

  Future<int> updateProfileInfo(ProfileModel profileInfo, String? token) async {
    // final auth = Auth();
    if (token == null) {
      print('token is null to do getme method...........');
      throw Exception('unauthorized access');
    }
    int? id = profileInfo.id;
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/profiles/$id';

    final response = await http.patch(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
        body: profileInfo.toJson());
    print('respon http.post:...' + response.body);

    final extractedResponse = json.decode(response.body);
    if (extractedResponse['message'] != null || response.statusCode != 200) {
      throw Exception('${extractedResponse['message']}');
    }

    return response.statusCode;
  }
}
