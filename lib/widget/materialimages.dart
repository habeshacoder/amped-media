import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class MaterialImages extends StatefulWidget {
  MaterialImages({required this.uploadProfilecover});
  final Function(dynamic) uploadProfilecover;

  @override
  State<MaterialImages> createState() => _MaterialImagesState();
}

class _MaterialImagesState extends State<MaterialImages> {
  String? pngFormateCheck;
  dynamic loadedImageUrl;
  String? sizeCheck;
  String? dimensionCheck;
  dynamic imageUrl;
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
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
      );

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
        //check the demenstion
        final image = Image.file(File(imagePath));

        final completer = Completer<ImageInfo>();
        image.image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info);
          }),
        );
        final info = await completer.future;
        final width = info.image.width;
        final height = info.image.height;
        if (width != 1920 || height != 1080) {
          print('${width} ${height}');
          setState(() {
            dimensionCheck = 'image dimensions must be 1920 x 1080';
          });
          return;
        }

        //update value
        setState(() {
          sizeCheck = null;
          dimensionCheck = null;
          pngFormateCheck = null;
          loadedImageUrl = path.basename(imagePath);
          imageUrl = imageFileFormate;
        });
      }
      widget.uploadProfilecover(imageUrl);
    } catch (error) {
      print('error:..${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      height: loadedImageUrl != null ? 200 : 155,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add more images'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Color(0XFF00A19A))),
            child: loadedImageUrl != null
                ? Center(child: Text('${loadedImageUrl}'))
                : TextButton.icon(
                    onPressed: __pickImage,
                    icon: Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Upload',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    )),
          ),
          if (loadedImageUrl != null)
            TextButton(
                onPressed: () {
                  setState(() {
                    loadedImageUrl = null;
                  });
                },
                child: Text(
                  'Change Image',
                  style: TextStyle(color: Color(0XFF00A19A)),
                )),
          Text('. Image must be in png or jog formate'),
          Text('. Size must be less than 1MB'),
          Text('. Image dimension must be 1920 X 1080'),
          if (dimensionCheck != null)
            Text(
              '. ${dimensionCheck}',
              style: TextStyle(color: Colors.red),
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
