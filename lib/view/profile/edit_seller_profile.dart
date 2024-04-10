import 'package:ampedmedia_flutter/model/profile.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/readerprofileprovider.dart';
import 'package:ampedmedia_flutter/url.dart';
import 'package:ampedmedia_flutter/view/profile/cover_image_update.dart';
import 'package:ampedmedia_flutter/view/profile/update_profile_image.dart';
import 'package:ampedmedia_flutter/view/update_password.dart';
import 'package:ampedmedia_flutter/widget/showalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditSellerProfile extends StatefulWidget {
  static const routName = '/EditSellerProfile';

  @override
  State<EditSellerProfile> createState() => _EditSellerProfileState();
}

class _EditSellerProfileState extends State<EditSellerProfile> {
  var initvalue = {};
  bool isInit = true;
  String initialSex = 'Male';
  dynamic _selectedDateofBirth = DateTime.now();
  final formFiled = GlobalKey<FormState>();
  bool isSendingCreateProfileRequest = false;
  dynamic coverImage;
  dynamic profileImage;
  ProfileModel profileinfo = ProfileModel(
    id: null,
    user_id: null,
    first_name: null,
    password: null,
    last_name: null,
    sex: null,
    date_of_birth: null,
    cover_image: null,
    profile_image: null,
    created_at: null,
    updated_at: null,
  );

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
    });
  }

  bool init = true;
  String? token;
  @override
  void didChangeDependencies() async {
    token = await Provider.of<Auth>(context, listen: false).token;

    if (init) {
      profileinfo = await Provider.of<ProfileProvider>(context, listen: false)
          .getMe(token);

      initvalue = {
        "id": profileinfo.id,
        "user_id": profileinfo.user_id,
        "first_name": profileinfo.first_name,
        "last_name": profileinfo.last_name,
        "sex": profileinfo.sex,
        "date_of_birth": profileinfo.date_of_birth,
        "profile_image": profileinfo.profile_image,
        "cover_image": profileinfo.cover_image,
        "created_at": profileinfo.created_at,
        "updated_at": profileinfo.updated_at
      };
      _firstNameController.text = profileinfo.first_name!;
      _lastNameController.text = profileinfo.last_name!;
      initialSex = profileinfo.sex!;
      _selectedDateofBirth = profileinfo.date_of_birth;
      profileImage = profileinfo.profile_image;
      coverImage = profileinfo.cover_image;
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(coverImage);
    var appBar = AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Text(
        'Account Information',
        style: TextStyle(color: Colors.black),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formFiled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                        ),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(headers: {
                            'Authorization': 'Bearer ${token}'
                          }, '${BackEndUrl.url}/profiles/cover-image/$coverImage'),
                        ),
                      ),
                      Positioned(
                        // bottom: 0,
                        top: 170,
                        left: MediaQuery.of(context).size.width * 0.75,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CoverImageUpdate(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(headers: {
                            'Authorization': 'Bearer ${token}'
                          }, '${BackEndUrl.url}/profiles/profile-image/$profileImage'),
                        ),
                      ),
                      Positioned(
                        // bottom: 0,
                        top: 40,
                        left: 50,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileImageUpdate(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: updateProfileData,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFF00A19A),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: isSendingCreateProfileRequest
                              ? CircularProgressIndicator()
                              : Text('Save Changes'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter f name',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 7),
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            profileinfo.first_name = newValue;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF00A19A),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text('edit'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter Last Name',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 7),
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            profileinfo.last_name = newValue;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF00A19A),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text('edit'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: initialSex,
                      hint: Text('select'),
                      items: <String>['Male', 'Female'].map((String value) {
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_selectedDateofBirth',
                        ),
                        InkWell(
                          onTap: _presentDatePicker,
                          child: Icon(Icons.date_range_sharp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '********',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 7),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PasswordUpdateForm(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF00A19A),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text('Change'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            )),
      ),
    );
  }

//update profile info
  void updateProfileData() async {
    print('started..................');
    if (!formFiled.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('error ocurred'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    formFiled.currentState!.save();
    profileinfo.sex = initialSex.toString();
    profileinfo.date_of_birth = _selectedDateofBirth.toString();
    setState(() {
      isSendingCreateProfileRequest = true;
    });
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }

      final responseData =
          await Provider.of<ProfileProvider>(context, listen: false)
              .updateProfileInfo(profileinfo, token);
      if (responseData == null || responseData != 200) {
        throw 'failed to update';
      }
      if (responseData == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile info successfully updated'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ShowAlert(message: error.toString());
    }
    setState(() {
      isSendingCreateProfileRequest = false;
    });
  }
}
