import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/provider/readerprofileprovider.dart';
import 'package:ampedmedia_flutter/widget/coverimageupload.dart';
import 'package:ampedmedia_flutter/widget/profileimageupload.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});
  static final routeName = '/ceateprofile';

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String initialSex = 'Male';
  bool? isContinue;
  dynamic _selectedDateofBirth = DateTime.now();

  //sign up data for form values
  final Map<String, dynamic> profileData = {
    "profileImage": "",
    "cover": "",
    "firstName": "",
    "LastName": "",
    "sex": "",
    "dateOfBirth": "",
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init focusnodes
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    //add listner
    firstNameFocusNode.addListener(() {
      if (!(firstNameFocusNode.hasFocus)) {
        firstName.currentState!.validate();
      }
    });
    lastNameFocusNode.addListener(() {
      if (!(lastNameFocusNode.hasFocus)) {
        lastName.currentState!.validate();
      }
    });
  }

//select profile image call back
  void uploadProfileImage(dynamic profileImageUrl) {
    print('profile image call back:..${profileImageUrl}');
    profileData["profileImage"] = profileImageUrl;
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
                  'Create Your Profile',
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
                          hintText: 'First Name',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: firstNameFocusNode,
                        key: firstName,
                        validator: SignUpFormHandler.fullNameValidator,
                        onSaved: (newValue) {
                          profileData["firstName"] = newValue;
                        },
                      ),
                    ),
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
                          hintText: 'Last Name',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: lastNameFocusNode,
                        key: lastName,
                        validator: SignUpFormHandler.fullNameValidator,
                        onSaved: (newValue) {
                          profileData["LastName"] = newValue;
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
    if (!firstName.currentState!.validate() ||
        !lastName.currentState!.validate() ||
        _selectedDateofBirth.isAfter(DateTime.now())) {
      return;
    }

    firstName.currentState!.save();
    lastName.currentState!.save();
    profileData["sex"] = initialSex;
    profileData["dateOfBirth"] = _selectedDateofBirth;
    setState(() {
      isSendingCreateProfileRequest = true;
    });

    final token = Provider.of<Auth>(context, listen: false).token;
    if (token == null) {
      throw 'you are not authenticated';
    }
    print('........................................now');
    isContinue = await Provider.of<ProfileProvider>(context, listen: false)
        .createProfile(profileData, token);
    print('after creating profile/////////////////////////');

    setState(() {
      isSendingCreateProfileRequest = false;
    });
    if (isContinue == true) {
      Navigator.of(context).popAndPushNamed('/');
    }
  }
}
