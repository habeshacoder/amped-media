import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/model/rate.dart';
import 'package:ampedmedia_flutter/provider/publisherprofileprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class materialCreationProvider with ChangeNotifier {
  List<MaterialModel> _createdMaterials = [];
  int? newMaterialId;

  List<MaterialModel> get getCreatedChannels {
    return _createdMaterials;
  }

  Future<int?> CreateMaterial(
      Map<String, dynamic> materialCreationData, String token) async {
    print('create material: ${materialCreationData['first_published_at']}');
    if (token == null) {
      throw 'you are not authenticated';
    }
    final publisherProvider = PublisherProfileProvder();
    final publisher = await publisherProvider.getMe(token);
    if (publisher.id == null) {
      throw 'you have no publisher profile';
    }
    materialCreationData['sellerProfile_id'] = publisher.id;
    print(materialCreationData['price']);
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material';
    print('token in createpro..................................:$token');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "parent": materialCreationData['parent'],
          "type": materialCreationData['type'],
          "genere": materialCreationData['genere'],
          "catagory": materialCreationData['catagory'],
          "title": materialCreationData['title'],
          "price": int.parse('${materialCreationData['price']}'),
          "description": materialCreationData['description'],
          "sellerProfile_id": materialCreationData['sellerProfile_id'],
          "author": materialCreationData['author'],
          "reader": materialCreationData['reader'],
          "translator": materialCreationData['translator'],
          "length_minute":
              int.parse('${materialCreationData['length_minute']}'),
          "length_page": int.parse('${materialCreationData['length_page']}'),
          "language": materialCreationData['language'],
          "publisher": materialCreationData['publisher'],
          "episode": int.parse('${materialCreationData['episode']}'),
          "continues_from":
              int.parse('${materialCreationData['continues_from']}'),
          "first_published_at": materialCreationData['first_published_at'] == 0
              ? 0
              : materialCreationData['first_published_at'].toString(),
        }),
      );
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

      print('after http.post called ...............');
      if (response.statusCode == 200 || response.statusCode == 201) {
        newMaterialId = extractedResponse['id'];
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }

    return newMaterialId;
  }

  //uload material
  Future<int?> uploadMaterial(
      String token, File previewFile, int? materialId) async {
    if (token == null) {
      throw 'you are not authenticated';
    }
    if (materialId == null) {
      throw 'First create channel ';
    }
    int? uploadedMaterialId;
    print('id value  profile image ${materialId}');
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material/upload/material';

    final request = http.MultipartRequest('POST', Uri.parse(url));
    final multipartFile = http.MultipartFile(
      'material',
      previewFile.readAsBytes().asStream(),
      previewFile.lengthSync(),
      filename: previewFile.path.split('/').last,
    );
    request.files.add(multipartFile);
    request.fields['id'] = materialId.toString();
    request.headers['Authorization'] = 'Bearer $token';
    // request.fields['id'] = jsonEncode(profile.id);
    // Future<void> uploadFile(File file) async {
    //   final url = 'YOUR_UPLOAD_URL';

    //   final request = http.MultipartRequest('POST', Uri.parse(url));
    //   final multipartFile = http.MultipartFile(
    //     'file',
    //     file.readAsBytes().asStream(),
    //     file.lengthSync(),
    //     filename: file.path.split('/').last,
    //   );
    //   request.files.add(multipartFile);
    //   double _progress;

    //   final response = await http.Response.fromStream(
    //     await request.send().asStream().
    //   );

    //   // Handle the response from the server
    // }

    try {
      final response = await request.send();
      final responseBody = await response.stream.transform(utf8.decoder).join();
      final responseBodyDecoded = jsonDecode(responseBody);
      print('response:................................${responseBody}');
      //check response
      final checkresponsebody = jsonDecode(responseBody);
      if (checkresponsebody['message'] != null) {
        throw checkresponsebody['message'];
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('pro image id....${checkresponsebody['id']}');
        uploadedMaterialId = checkresponsebody['id'];

        notifyListeners();
      } else {
        throw 'Failed to upload Cover Image: ${response.statusCode}';
      }
    } catch (error) {
      throw error;
    }
    print('prof imm id...........................${uploadedMaterialId}');
    return uploadedMaterialId;
  }

  //get  material by type
  Future<List<MaterialModel>> getMaterialByType(String type) async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material/get_by/${type}';

    final response = await http.get(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'});
    print('getmaterial by type run...');

    print(response.body);
    List<MaterialModel> loadedMaterials = [];

    final extractedResponse = json.decode(response.body);
    try {
      extractedResponse.forEach((mat) {
        loadedMaterials.add(MaterialModel.fromJson(mat));
      });
      print(loadedMaterials);
    } catch (error) {
      print('eror......:${error}');
    }

    return loadedMaterials;
  }

  //get  material by type
  Future<List<MaterialModel>> getMaterialByParent(String parent) async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material/materials_by/${parent}';

    final response = await http.get(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'});
    print('getmaterial by type run...');

    print(response.body);
    List<MaterialModel> loadedMaterials = [];

    final extractedResponse = json.decode(response.body);
    try {
      extractedResponse.forEach((mat) {
        loadedMaterials.add(MaterialModel.fromJson(mat));
      });
      print(loadedMaterials);
    } catch (error) {
      print('eror......:${error}');
    }

    return loadedMaterials;
  }

  //get  material by type
  Future<List<dynamic>> getMaterialByAudio(String parent) async {
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material/materials_by/${parent}';

    final response = await http.get(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'});
    print('getmaterial by type run...');

    print(response.body);
    List<MaterialModel> loadedMaterials = [];

    final extractedResponse = json.decode(response.body);
    // try {
    //   extractedResponse.forEach((mat) {
    //     loadedMaterials.add(MaterialModel.fromJson(mat));
    //   });
    //   print(loadedMaterials);
    // } catch (error) {
    //   print('eror......:${error}');
    // }

    return extractedResponse;
  }

//get material by id
  Future<MaterialModel> getMaterialById(int? id, String token) async {
    final baseUrl = BackEndUrl.url;
    print('materilid:...........:${id}');
    final url = '$baseUrl/material/${id}';
    final material;

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    List<MaterialModel> loadedMaterials = [];

    final extractedResponse = json.decode(response.body);
    print('extra..............${extractedResponse}');
    material = MaterialModel.fromJson(extractedResponse, isUpload: true);
    print(loadedMaterials);

    return material;
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
            "material_id": reviewDat['material_id'],
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
  Future<List<Rate>> getRates(String? token, int material_id) async {
    // final auth = Auth();
    if (token == null) {
      print('token is null to do getme method...........');
      throw Exception('unauthorized access');
    }
    final List<Rate> rates = [];

    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/rate/material/${material_id}';

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

  //get rates information
  Future<dynamic> getAvgRate(String? token, int material_id) async {
    // final auth = Auth();
    if (token == null) {
      print('token is null to do getme method...........');
      throw Exception('unauthorized access');
    }
    dynamic avgRate;

    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/rate/material/${material_id}';

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

      avgRate = extractedResponse['rating'];

      print(avgRate);
    } catch (error) {
      print(error);
      throw error;
    }

    print('sample here');

    return avgRate;
  }

  //get material by author
  Future<List<MaterialModel>> getMaterialByAuthor(int sellerProfileId,
      {bool isFromMoreDetailView = false}) async {
    dynamic avgRate;
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material/seller/${sellerProfileId}';
    List<MaterialModel> loadedMaterials = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final extractedResponse = json.decode(response.body);

      print('after http.post called ...............${extractedResponse}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('${extractedResponse['message']}');
      }

      extractedResponse.forEach((mat) {
        loadedMaterials.add(MaterialModel.fromJson(mat));
      });
    } catch (error) {
      throw error;
    }

    return isFromMoreDetailView
        ? loadedMaterials.take(3).toList()
        : loadedMaterials;
  }

  //upload material image cover preview and file at once
  Future<bool?> createMaterialData(Map<String, dynamic> materialData,
      String token, MaterialModel? material) async {
    print('material id:${material!.id}');
    if (material == null) {
      throw 'material is null';
    }
    // if(material.type=='')
    bool? Iscontinue;
    final baseUrl = BackEndUrl.url;
    final url = '$baseUrl/material/files/${material.id}';
    File profileImage = materialData["materialImage"];
    File coverImage = materialData["cover"];
    File preview = materialData["preview"];
    File materialFile = materialData["material"];
    File materialImages =
        materialData["images"] != null ? materialData["images"] : null;

    final formDataRequest = http.MultipartRequest('POST', Uri.parse(url));
    //create a multipart
    final materialProfile = http.MultipartFile(
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
    final previewMultiPart = http.MultipartFile(
      'preview',
      preview.readAsBytes().asStream(),
      preview.lengthSync(),
      filename: preview.path.split('/').last,
    );
    final materialFileMultiPart = http.MultipartFile(
      'material',
      materialFile.readAsBytes().asStream(),
      materialFile.lengthSync(),
      filename: materialFile.path.split('/').last,
    );
    final materialImagesMultipart = http.MultipartFile(
      'images',
      materialImages.readAsBytes().asStream(),
      materialImages.lengthSync(),
      filename: materialImages.path.split('/').last,
    );
    print('begin uploading add files multipar.......');

    //add files
    formDataRequest.files.add(materialProfile);
    formDataRequest.files.add(coverMultipart);
    formDataRequest.files.add(previewMultiPart);
    formDataRequest.files.add(materialFileMultiPart);
    formDataRequest.files.add(materialImagesMultipart);

    formDataRequest.headers['Authorization'] = 'Bearer $token';
    //send to back end

    final response = await formDataRequest.send();
    print('Upload progress...................: $response');

    final responseBody = await response.stream.transform(utf8.decoder).join();
    final responseBodyDecoded = jsonDecode(responseBody);
    print(
        'response in material datas :.............${response.statusCode}...${responseBody}');
    //check response
    final checkresponsebody = jsonDecode(responseBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Iscontinue = true;
    } else {
      throw 'faild to create seller profile';
    }

    return Iscontinue;
  }
}
