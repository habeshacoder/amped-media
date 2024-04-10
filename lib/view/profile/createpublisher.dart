import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/provider/publisherprofileprovider.dart';
import 'package:ampedmedia_flutter/widget/coverimageupload.dart';
import 'package:ampedmedia_flutter/widget/profileimageupload.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreatePublisherProfile extends StatefulWidget {
  const CreatePublisherProfile({super.key});

  @override
  State<CreatePublisherProfile> createState() => _CreatePublisherProfileState();
}

class _CreatePublisherProfileState extends State<CreatePublisherProfile> {
  String initialSex = 'Male';
  bool? isContinue;
  int minimum = 100;
  DateTime _selectedDateofBirth = DateTime.now();

  //sign up data for form values
  final Map<String, dynamic> profileData = {
    "profile": "",
    "cover": "",
    "name": "",
    "description": "",
    "sex": "",
    "dateOfBirth": "",
  };
  //
  var isSendingCreateProfileRequest = false;
  //declare focus node
  var nameFocusNode;
  var descriptionFoucsNode;
  //initialize each field's key
  final name = GlobalKey<FormFieldState>();
  final descriptionKey = GlobalKey<FormFieldState>();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init focusnodes
    nameFocusNode = FocusNode();
    descriptionFoucsNode = FocusNode();
    //add listner
    nameFocusNode.addListener(() {
      if (!(nameFocusNode.hasFocus)) {
        name.currentState!.validate();
      }
    });
    descriptionFoucsNode.addListener(() {
      if (!(descriptionFoucsNode.hasFocus)) {
        descriptionKey.currentState!.validate();
      }
    });
  }

//select profile image call back
  void uploadProfileImage(dynamic profileImageUrl) {
    print('profile image call back:..${profileImageUrl}');
    profileData["profile"] = profileImageUrl;
  }

  //slect cover image
  void uploadProfileCover(dynamic profileCoverUrl) {
    print('profile image call back:..${profileCoverUrl}');
    profileData["cover"] = profileCoverUrl;
  }

  @override
  Widget build(BuildContext context) {
    //
    void _presentDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1000),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDateofBirth = pickedDate;
        });
        profileData["dateOfBirth"] = _selectedDateofBirth;
      });
    }

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
                  'Create Your seller Profile',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ProfileImgaeUpload(uploadProfileImage: uploadProfileImage),
              Form(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          suffixIcon: Icon(Icons.person),
                          suffixIconColor: Colors.grey,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 7),
                          filled: true,
                          fillColor: Colors.white60,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                          hintText: 'name',
                        ),
                        focusNode: nameFocusNode,
                        key: name,
                        validator: SignUpFormHandler.fullNameValidator,
                        onSaved: (newValue) {
                          profileData["name"] = newValue;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        maxLength: 100,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 7),
                          filled: true,
                          fillColor: Colors.white60,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                          hintText: 'Description...',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: descriptionFoucsNode,
                        key: descriptionKey,
                        onChanged: (value) {
                          setState(() {
                            minimum = minimum - value.length;
                          });
                        },
                        validator: SignUpFormHandler.fullNameValidator,
                        onSaved: (newValue) {
                          profileData["description"] = newValue;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sex'),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    value: initialSex,
                                    hint: Text('select'),
                                    items: <String>['Male', 'Female']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        initialSex = value as String;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text('Date of Birth'),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      ' ${DateFormat.yMd().format(_selectedDateofBirth)}',
                                    ),
                                    InkWell(
                                        onTap: _presentDatePicker,
                                        child: Icon(Icons.date_range_sharp))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ProfileCoverImgaeUpload(uploadProfilecover: uploadProfileCover),
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
    if (!name.currentState!.validate() ||
        !descriptionKey.currentState!.validate() ||
        _selectedDateofBirth.isAfter(DateTime.now())) {
      return;
    }

    name.currentState!.save();
    descriptionKey.currentState!.save();
    profileData["sex"] = initialSex;
    profileData["dateOfBirth"] = _selectedDateofBirth;
    setState(() {
      isSendingCreateProfileRequest = true;
    });
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }

      isContinue =
          await Provider.of<PublisherProfileProvder>(context, listen: false)
              .createSellerProfile(profileData, token);
    } catch (error) {
      print(
          'object...........................................................$error');
      showalert('$error');
    }
    setState(() {
      isSendingCreateProfileRequest = false;
    });
    if (isContinue == true) {
      Navigator.of(context).popAndPushNamed('/');
    }
  }
}
