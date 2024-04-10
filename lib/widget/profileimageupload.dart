import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImgaeUpload extends StatefulWidget {
  ProfileImgaeUpload({required this.uploadProfileImage});
  final Function(dynamic) uploadProfileImage;
  @override
  State<ProfileImgaeUpload> createState() => _ProfileImgaeUploadState();
}

class _ProfileImgaeUploadState extends State<ProfileImgaeUpload> {
  dynamic loadedImageUrl;
  dynamic imageUrl;
  String? pngFormateCheck;
  String? sizeCheck;
  String? dimensionCheck;
  String? isImageUrlEmpty;
  bool isSendingCreateProfileRequest = false;
  //display error message to user
  void showalert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('an error occured'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('okay'),
            )
          ],
        );
      },
    );
  }

  //profile image picker
  Future<void> __pickImage() async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imagePath = pickedFile.path;

        final imageFileFormate = File(imagePath);
        //extention formate validation
        final isPngOrJpg = ['.png', '.jpg', '.jpeg']
            .any((extension) => imagePath.toLowerCase().endsWith(extension));
        if (!isPngOrJpg) {
          print('File must be in PNG or JPG format');
          setState(() {
            pngFormateCheck = 'File must be in PNG or JPG format';
          });
          return;
        }
        // Handle size
        final fileSize = await imageFileFormate.length();
        if (fileSize >= 1000000) {
          print('File size must be less than 1MB');
          setState(() {
            sizeCheck = 'File size must be less than 1MB';
          });
          return;
        }

        //update value
        setState(() {
          sizeCheck=null;
          dimensionCheck=null;
          pngFormateCheck=null;
          loadedImageUrl = path.basename(imagePath);
          imageUrl = imageFileFormate;
        });
      }

      widget.uploadProfileImage(imageUrl);
    } catch (error) {
      print('error:..${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                //profile image
                Container(
                  height: 141,
                  width: 141,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF00A19A)),
                  child: imageUrl != null
                      ? CircleAvatar(
                          child: Image.file(
                            imageUrl as File,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : Image(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/Vector.png')),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: InkWell(
                      onTap: () async {
                        __pickImage();
                      },
                      child: Container(
                          color: Colors.white,
                          child: Icon(Icons.camera_alt_outlined)),
                    )),
              ],
            ),
          ),
          if (sizeCheck != null)
            Text(
              '. ${sizeCheck}',
              style: TextStyle(color: Colors.red),
            ),
          if (pngFormateCheck != null)
            Text(
              '. ${pngFormateCheck}',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
