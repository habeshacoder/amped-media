import 'package:ampedmedia_flutter/view/profile/uploadchannelmaterial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateChannel extends StatefulWidget {
  const CreateChannel({super.key});
  static final routeName = '/ceateprofile';

  @override
  State<CreateChannel> createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
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
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 174,
                      // color: Colors.red,
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 141,
                              width: 141,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00A19A)),
                              child: Image(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/images/demuuyimages/Camera.png')),
                            ),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: null,
                                  child: Container(
                                    color: Colors.white,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/demuuyimages/Edit.png'),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10, top: 1),
                            child: Text('Upload Your Channel Image'))),

                    // Text('Full Name'),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye),
                          suffixIconColor: Colors.grey,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 7),
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
                          // focusColor: Colors.grey,
                          // labelText: 'Full Name',
                          hintText: 'Channel Name',
                        ),
                        obscureText: true,
                        controller: null,
                        // validator:
                        onSaved: null,
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Text('Add Detail of Your Channel'),
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
                          // filled: true,

                          // fillColor: Colors.white60,
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.black, width: 0),
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          // focusColor: Colors.grey,
                          // labelText: 'Full Name',
                          hintText: 'My Channel...',
                        ),
                        // obscureText: true,
                        controller: null,
                        // validator:
                        onSaved: null,
                      ),
                    ),
                    Text('only 2100 characters'),
                    SizedBox(
                      height: 13,
                    ),

                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                      margin: EdgeInsets.symmetric(vertical: 13),
                      width: double.infinity,
                      color: Colors.grey[350],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add a Cover Image'),
                          SizedBox(
                            height: 3,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFF00A19A), width: 1),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: double.infinity,
                              child: TextButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.upload),
                                label: Text(
                                  'Upload',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('- Image must be in jpg or pnj format'),
                          Text('- Size must be less than 1mb '),
                          Text('- Cover Image must be 1920x1080'),
                          Text('- you can add up to 10 images'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5,
                    bottom: 100,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF00A19A),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text('Next'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UploadChannelMaterial(),
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
