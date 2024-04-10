import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class MaterialPreview extends StatefulWidget {
  MaterialPreview({required this.pickAudio});
  final void Function(dynamic) pickAudio;

  @override
  State<MaterialPreview> createState() => _MaterialPreviewState();
}

class _MaterialPreviewState extends State<MaterialPreview> {
  String? pngFormateCheck;
  dynamic loadedPreviewFile;
  String? sizeCheck;
  String? dimensionCheck;
  dynamic previeFileUrl;
  String? isImageUrlEmpty;
  bool isSendingCreateProfileRequest = false;
  XFile? _audioFile;
  dynamic filePath;
  PlatformFile? file;
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

  void pickAndCheckFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      print('.........................${file}');
      int fileSizeInBytes = file.lengthSync();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      String fileExtension = path.extension(file.path);
      //check the extension
      if (fileExtension != '.wav' &&
          fileExtension != '.mp3' &&
          fileExtension != '.epub') {
        print('invalid extension');
        return;
      }
      //check the size
      if (fileSizeInMB > 1) {
        print('size is big');
        return;
      }
      setState(() {
        loadedPreviewFile = path.basename(file.toString());
      });
      widget.pickAudio(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      height: loadedPreviewFile != null ? 200 : 155,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add material Preview'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Color(0XFF00A19A))),
            child: loadedPreviewFile != null
                ? Center(child: Text('${loadedPreviewFile}'))
                : TextButton.icon(
                    onPressed: pickAndCheckFile,
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
          if (loadedPreviewFile != null)
            TextButton(
                onPressed: () {
                  setState(() {
                    loadedPreviewFile = null;
                  });
                },
                child: Text(
                  'Change Image',
                  style: TextStyle(color: Color(0XFF00A19A)),
                )),
          Text('. Preview must be in .wav/.mp3/.epub formate'),
          Text('. Size must be less than 1MB'),
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
