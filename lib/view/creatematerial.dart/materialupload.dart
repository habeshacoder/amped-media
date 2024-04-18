import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/widget/coverimageupload.dart';
import 'package:ampedmedia_flutter/widget/materialfile.dart';
import 'package:ampedmedia_flutter/widget/materialimages.dart';
import 'package:ampedmedia_flutter/widget/materialpreview.dart';
import 'package:ampedmedia_flutter/widget/profileimageupload.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaterialUpload extends StatefulWidget {
  const MaterialUpload({this.materialId});
  final int? materialId;

  @override
  State<MaterialUpload> createState() => _MaterialUploadState();
}

class _MaterialUploadState extends State<MaterialUpload> {
  dynamic _selectedDateofBirth = DateTime.now();

  //sign up data for form values
  final Map<String, dynamic> materialUploadData = {
    "materialImage": "",
    "cover": "",
    "preview": "",
    "material": "",
    "images": "",
  };

  var isSendingCreateProfileRequest = false;
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

//select profile image call back
  void uploadProfileImage(dynamic materialProfileImage) {
    print('profile image call back:..${materialProfileImage}');
    materialUploadData["materialImage"] = materialProfileImage;
  }

  //slect cover image
  void uploadProfileCover(dynamic materialCover) {
    print('...........materialCover${materialCover}');
    materialUploadData["cover"] = materialCover;
  }

  //select material preview
  void uploadPreview(dynamic materialPreview) {
    print('profile image call back:..${materialPreview}');
    materialUploadData["preview"] = materialPreview;
  }

  //slect material file
  void materialFile(dynamic materialFile) {
    print('profile image call back:..${materialFile}');
    materialUploadData["material"] = materialFile;
  }

  //slect material file
  void materialImages(dynamic materialFile) {
    print('profile image call back:..${materialFile}');
    materialUploadData["images"] = materialFile;
  }

  @override
  Widget build(BuildContext context) {
    //

    var appBar = AppBar(
      backgroundColor: Color(0xF0F9F8),
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black54,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    'Upload Material Information',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              ProfileImgaeUpload(uploadProfileImage: uploadProfileImage),
              ProfileCoverImgaeUpload(uploadProfilecover: uploadProfileCover),
              MaterialPreview(pickAudio: uploadPreview),
              MaterialFile(pickedMaterialFile: materialFile),
              MaterialImages(uploadProfilecover: materialImages),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFF00A19A),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: isSendingCreateProfileRequest
                        ? CircularProgressIndicator()
                        : Text('Continue'),
                    onPressed: createProfile,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //sign up method
  void createProfile() async {
    setState(() {
      isSendingCreateProfileRequest = true;
    });
    MaterialModel materialbackEnd;
    bool? isDone;

    final token = Provider.of<Auth>(context, listen: false).token;
    if (token == null) {
      throw 'you are not authenticated';
    }
    final material =
        Provider.of<materialCreationProvider>(context, listen: false)
            .getMaterialById(widget.materialId, token);
    materialbackEnd = await material;
    print(
        '........................................materialbackEnd${materialbackEnd.type}');
    isDone = await Provider.of<materialCreationProvider>(context, listen: false)
        .createMaterialData(materialUploadData, token, materialbackEnd);

    setState(() {
      isSendingCreateProfileRequest = false;
    });
    if (isDone == true) {
      Navigator.of(context).pushNamed('/');
    }
  }
}
