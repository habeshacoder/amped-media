import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/provider/readerprofileprovider.dart';
import 'package:ampedmedia_flutter/widget/coverimageupload.dart';
import 'package:ampedmedia_flutter/widget/profileimageupload.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CoverImageUpdate extends StatefulWidget {
  const CoverImageUpdate({super.key});
  static final routeName = '/ceateprofile';

  @override
  State<CoverImageUpdate> createState() => _CoverImageUpdateState();
}

class _CoverImageUpdateState extends State<CoverImageUpdate> {
  bool? isContinue;

  //sign up data for form values
  final Map<String, dynamic> profileData = {
    "cover": "",
  };
  //
  var isSendingCreateProfileRequest = false;
  //declare focus node
  var firstNameFocusNode;
  var lastNameFocusNode;
  //initialize each field's key
  final firstName = GlobalKey<FormFieldState>();
  final lastName = GlobalKey<FormFieldState>();

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

  //slect cover image
  void uploadProfileCover(dynamic profileCoverUrl) {
    print('profile image call back:..${profileCoverUrl}');
    profileData["cover"] = profileCoverUrl;
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  'You Can change Your Profile Cover Image',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              // ProfileImgaeUpload(uploadProfileImage: uploadProfileImage),
              ProfileCoverImgaeUpload(uploadProfilecover: uploadProfileCover),
              SizedBox(
                height: 60,
              ),
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
                        : Text('Save Change'),
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
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }
      isContinue = await Provider.of<ProfileProvider>(context, listen: false)
          .UpdateProfileCover(profileData, token);
    } catch (error) {
      showalert('$error');
    }
    setState(() {
      isSendingCreateProfileRequest = false;
    });
    if (isContinue == true) {
      Navigator.of(context).pop();
    }
  }
}
