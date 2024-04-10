import 'package:ampedmedia_flutter/model/channelmodel.dart';
import 'package:ampedmedia_flutter/model/publisherprofilemodel.dart';
import 'package:ampedmedia_flutter/model/rate.dart';
import 'package:ampedmedia_flutter/model/subscriptionplan.dart';
import 'package:ampedmedia_flutter/provider/publisherprofileprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChannelCreationProvider with ChangeNotifier {
  List<ChannelModel> createdChannels = [];
  int? newChannelId;

  List<ChannelModel> get getCreatedChannels {
    return createdChannels;
  }

  // create channel
  Future<ChannelModel> createChannel(
      Map<String, dynamic> profileData, String token) async {
    if (token == null) {
      throw 'unautherized';
    }
    print(profileData["name"]);
    print(profileData["profile"]);
    print(profileData["cover"]);
    print(profileData["sellerProfile_id"]);
    print(profileData["description"]);
    //
    ChannelModel channel;
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/channel';
    File profileImage = profileData["profile"];
    File coverImage = profileData["cover"];
    try {
      //get publisher data
      PublisherProfileModel publisher;
      final responsePublisher = await PublisherProfileProvder().getMe(token);
      publisher = await responsePublisher;
      if (publisher.id == null) {
        throw 'faild to create channel';
      }
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
      formDataRequest.fields['name'] = profileData["name"];
      formDataRequest.fields['description'] = profileData["description"];
      formDataRequest.fields['sellerProfile_id'] = '${publisher.id}';

      formDataRequest.headers['Authorization'] = 'Bearer $token';
      //send to back end
      final response = await formDataRequest.send();
      final responseBody = await response.stream.transform(utf8.decoder).join();
      final responseBodyDecoded = jsonDecode(responseBody);
      //check response
      final checkresponsebody = jsonDecode(responseBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        channel = ChannelModel.fromJson(checkresponsebody);
      } else {
        throw 'faild to create profile';
      }
    } catch (error) {
      throw error;
    }

    return channel;
  }

  //create subscription plan
  Future<SubscriptionPlan> addSubscriptionPlan(
      String token, dynamic subscriptionPlanData) async {
    if (token == null) {
      throw 'failed to create. unautherised';
    }
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/subscription-plan';
    SubscriptionPlan subscriptionPlan;
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "name": subscriptionPlanData['name'],
            "description": subscriptionPlanData['description'],
            "price": subscriptionPlanData['price'],
            "channel_id": subscriptionPlanData['material_id'],
          }));
      //
      final extractedResponse = json.decode(response.body);
      if (response.statusCode == 200 && response.statusCode == 201) {
        //
        subscriptionPlan = SubscriptionPlan.fromJson(extractedResponse);
      } else {
        throw extractedResponse['message'];
      }
    } catch (error) {
      throw '$error';
    }

    return subscriptionPlan;
  }

  Future<List<ChannelModel>> seeAllChannel() async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/channel';

    final response = await http.get(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'});
    List<ChannelModel> loadedChannels = [];

    final extractedResponse = json.decode(response.body);
    try {
      extractedResponse.forEach((mat) {
        loadedChannels.add(ChannelModel.fromJson(mat));
      });
      print(loadedChannels);
    } catch (error) {
      print('eror......:${error}');
    }

    return loadedChannels;
  }

  //rate material
  Future<void> rateMaterial(String token, dynamic reviewDat) async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/rate';

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "rating": reviewDat['rating'],
            "remark": reviewDat['remark'],
            "channel_id": reviewDat['material_id'],
          }));
      //
      final extractedResponse = json.decode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        // print(extractedResponse["message"]);
        throw extractedResponse["message"];
      }
    } catch (error) {
      print('eror......:${error}');
      throw '$error';
    }

    return;
  }

  //get rates information
  Future<List<Rate>> getRates(String? token, int channel_id) async {
    // final auth = Auth();
    if (token == null) {
      print('token is null to do getme method...........');
      throw Exception('unauthorized access');
    }
    final List<Rate> rates = [];

    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/rate/channel/${channel_id}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );
      final extractedResponse = json.decode(response.body);

      print('after http.post called ...............${extractedResponse}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('inside get rate.....');
        throw Exception('${extractedResponse['message']}');
      }

      extractedResponse['rate'].forEach((rate) {
        rates.add(Rate.fromJson(rate));
      });
      print(rates);
    } catch (error) {
      print(error);
      throw error;
    }

    print('sample here');

    return rates;
  }
}
