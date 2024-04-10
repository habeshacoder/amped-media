import 'package:ampedmedia_flutter/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadChannelMaterial extends StatefulWidget {
  const UploadChannelMaterial({super.key});
  static final routeName = '/ceateprofile';

  @override
  State<UploadChannelMaterial> createState() => _UploadChannelMaterialState();
}

class _UploadChannelMaterialState extends State<UploadChannelMaterial> {
  String initialChannelType = 'Book';

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
                  'Upload Material',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Channel Type'),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 7),
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
                              ),
                              value: initialChannelType,
                              hint: Text('select'),
                              items: <String>['Book', 'Audiobook', 'Podcast']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  initialChannelType = value as String;
                                });
                              },
                            ),
                          ),
                        )
                      ],
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
                          Text('Add Channel Material '),
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
                                  'Upload File',
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
                          Text('Add a  Image'),
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
                                  'Upload Images',
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
                                  'Upload Images',
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
                    ),
                    Text('Title of the Material'),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
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
                          hintText: 'Enter title of the material',
                        ),
                        obscureText: true,
                        controller: null,
                        // validator:
                        onSaved: null,
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: Text('Finish'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DashBoard(),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                  minLines: 3,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    // filled: true,

                    // fillColor: Colors.white60,
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: 0),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Channel Type'),
                  // Container(
                  //   margin: EdgeInsets.only(top: 5),
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     height: 50,
                  //     child: DropdownButtonFormField<String>(
                  //       decoration: const InputDecoration(
                  //         contentPadding:
                  //             const EdgeInsets.symmetric(horizontal: 7),
                  //         filled: true,
                  //         fillColor: Colors.white60,
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(color: Colors.black, width: 0),
                  //         ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(color: Colors.grey, width: 0),
                  //         ),
                  //       ),
                  //       value: 'initialChannelType',
                  //       hint: Text('select'),
                  //       items: <String>['Book', 'Audiobook', 'Podcast']
                  //           .map((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //       onChanged: (value) {
                  //         setState(() {
                  //           initialChannelType = value as String;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
