import 'package:ampedmedia_flutter/model/channelmodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/channelcreationprovider.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/view/createchannel/addsubscriptionplan.dart';
import 'package:ampedmedia_flutter/widget/coverimageupload.dart';
import 'package:ampedmedia_flutter/widget/profileimageupload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateNewChannel extends StatefulWidget {
  const CreateNewChannel({super.key});
  static final routeName = '/ceateprofile';

  @override
  State<CreateNewChannel> createState() => _CreateNewChannelState();
}

class _CreateNewChannelState extends State<CreateNewChannel> {
  //sign up data for form values
  final Map<String, dynamic> createChannelData = {
    "name": "",
    "description": "",
    "sellerProfile_id": 15,
    "profile": "",
    "cover": "",
  };

  var isSendingCreateProfileRequest = false;
  //declare focus node
  var nameFocusNode;
  var descriptionFocusNode;
  // var seller
  //initialize each field's key
  final nameKey = GlobalKey<FormFieldState>();
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
    descriptionFocusNode = FocusNode();
    //add listner
    nameFocusNode.addListener(() {
      if (!(nameFocusNode.hasFocus)) {
        nameKey.currentState!.validate();
      }
    });
    descriptionFocusNode.addListener(() {
      if (!(descriptionFocusNode.hasFocus)) {
        descriptionKey.currentState!.validate();
      }
    });
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

//select profile image call back
  void uploadProfileImage(dynamic channelProfileImage) {
    print('profile image call back:..${channelProfileImage}');
    createChannelData["profile"] = channelProfileImage;
  }

  //slect cover image
  void uploadProfileCover(dynamic channelcoverImage) {
    print('...........channelcoverImage${channelcoverImage}');
    createChannelData["cover"] = channelcoverImage;
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
                child: Text(
                  'Create Your Channel',
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
                          hintText: 'Enter  Your Channel Name',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: nameFocusNode,
                        key: nameKey,
                        validator: SignUpFormHandler.fullNameValidator,
                        onSaved: (newValue) {
                          createChannelData["name"] = newValue;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text('Add Description'),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2100),
                        ],
                        minLines: 7,
                        maxLines: 7,
                        decoration: const InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          // focusColor: Colors.grey,
                          // labelText: 'Full Name',
                          hintText: 'I am a pulisher...',
                        ),
                        // obscureText: true,
                        controller: null,
                        focusNode: descriptionFocusNode,
                        key: descriptionKey,
                        validator: SignUpFormHandler.discriptionValidator,
                        onSaved: (newValue) {
                          createChannelData["description"] = newValue;
                        },
                        // validator:
                      ),
                    ),
                    Text('only 2100 characters'),
                    SizedBox(
                      height: 13,
                    ),
                  ],
                ),
              ),
              ProfileCoverImgaeUpload(uploadProfilecover: uploadProfileCover),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 90),
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
    if (!nameKey.currentState!.validate() ||
        !descriptionKey.currentState!.validate()) {
      return;
    }
    ChannelModel? channel;

    nameKey.currentState!.save();
    descriptionKey.currentState!.save();
    setState(() {
      isSendingCreateProfileRequest = true;
    });
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }

      final responseData =
          await Provider.of<ChannelCreationProvider>(context, listen: false)
              .createChannel(createChannelData, token);
      if (responseData == null) {
        throw 'faile to create channel';
      }
      channel = await responseData;
    } catch (error) {
      print(error);
      print(
          'object...........................................................$error');
      showalert('$error');
    }
    setState(() {
      isSendingCreateProfileRequest = false;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddSubscriptionPlan(
        channel: channel,
      ),
    ));
  }
}
