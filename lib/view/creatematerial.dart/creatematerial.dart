import 'dart:io';

import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/view/creatematerial.dart/materialupload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateMaterial extends StatefulWidget {
  const CreateMaterial({super.key});

  @override
  State<CreateMaterial> createState() => _CreateMaterialState();
}

class _CreateMaterialState extends State<CreateMaterial> {
  //sign up data for form values
  final Map<String, dynamic> createMaterialData = {
    "parent": "Unspecified",
    "type": "Unspecified",
    "genere": "Unspecified",
    "catagory": "Unspecified",
    "title": "",
    "price": 0,
    "description": "",
    "sellerProfile_id": 15,
    "author": "",
    "reader": "",
    "translator": "",
    "length_minute": 0,
    "length_page": 0,
    "language": "",
    "publisher": "",
    "episode": 0,
    "continues_from": 0,
    "first_published_at": 0
  };
  //initialize each field's key
  final parentKey = GlobalKey<FormFieldState>();
  final typeKey = GlobalKey<FormFieldState>();
  final genereKey = GlobalKey<FormFieldState>();
  final catagoryKey = GlobalKey<FormFieldState>();
  final titleKey = GlobalKey<FormFieldState>();
  final descriptionKey = GlobalKey<FormFieldState>();
  final priceKey = GlobalKey<FormFieldState>();
  final authorKey = GlobalKey<FormFieldState>();
  final readerKey = GlobalKey<FormFieldState>();
  final translatorKey = GlobalKey<FormFieldState>();
  final length_minuteKey = GlobalKey<FormFieldState>();
  final length_pageKey = GlobalKey<FormFieldState>();
  final languageKey = GlobalKey<FormFieldState>();
  final publisherKey = GlobalKey<FormFieldState>();
  final episodeKey = GlobalKey<FormFieldState>();
  final continues_fromKey = GlobalKey<FormFieldState>();
  final first_published_atKey = GlobalKey<FormFieldState>();
  //
  var isSendingSignUpRequestWithEmail = false;
  //declare focus node
  var parentFocusNode;
  var typeFocusNode;
  var generFocusNode;
  var categoryFocusNode;
  var titleFocusNode;
  var descriptionFocusNode;
  var priceFocusNode;
  var authorFocusNode;
  var readerFocusNode;
  var translatorFocusNode;
  var length_minuteFocusNode;
  var length_pageFocusNode;
  var languageFocusNode;
  var publisherFocusNode;
  var episodeFocusNode;
  var continues_fromFocusNode;
  var first_published_atFocusNode;

  final GlobalKey<FormState> _createChannelformKey = GlobalKey();
  //controller

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
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark, // dark text for status bar
        systemNavigationBarColor: Colors.white,
      ),
    );
    //init focusnodes
    parentFocusNode = FocusNode();
    typeFocusNode = FocusNode();
    generFocusNode = FocusNode();
    categoryFocusNode = FocusNode();
    titleFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    authorFocusNode = FocusNode();
    readerFocusNode = FocusNode();
    translatorFocusNode = FocusNode();
    languageFocusNode = FocusNode();
    length_minuteFocusNode = FocusNode();
    length_pageFocusNode = FocusNode();
    publisherFocusNode = FocusNode();
    episodeFocusNode = FocusNode();
    continues_fromFocusNode = FocusNode();
    first_published_atFocusNode = FocusNode();
    //add listner
    parentFocusNode.addListener(() {
      if (!(parentFocusNode.hasFocus)) {
        parentKey.currentState!.validate();
      }
    });
    typeFocusNode.addListener(() {
      if (!(typeFocusNode.hasFocus)) {
        typeKey.currentState!.validate();
      }
    });
    generFocusNode.addListener(() {
      if (!(generFocusNode.hasFocus)) {
        genereKey.currentState!.validate();
      }
    });
    categoryFocusNode.addListener(() {
      if (!(categoryFocusNode.hasFocus)) {
        catagoryKey.currentState!.validate();
      }
    });
    titleFocusNode.addListener(() {
      if (!(titleFocusNode.hasFocus)) {
        titleKey.currentState!.validate();
      }
    });
    descriptionFocusNode.addListener(() {
      if (!(descriptionFocusNode.hasFocus)) {
        descriptionKey.currentState!.validate();
      }
    });
    priceFocusNode.addListener(() {
      if (!(priceFocusNode.hasFocus)) {
        priceKey.currentState!.validate();
      }
    });
    authorFocusNode.addListener(() {
      if (!(authorFocusNode.hasFocus)) {
        authorKey.currentState!.validate();
      }
    });
    readerFocusNode.addListener(() {
      if (!(readerFocusNode.hasFocus)) {
        readerKey.currentState!.validate();
      }
    });
    translatorFocusNode.addListener(() {
      if (!(translatorFocusNode.hasFocus)) {
        translatorKey.currentState!.validate();
      }
    });
    length_minuteFocusNode.addListener(() {
      if (!(length_minuteFocusNode.hasFocus)) {
        length_minuteKey.currentState!.validate();
      }
    });
    length_pageFocusNode.addListener(() {
      if (!(length_pageFocusNode.hasFocus)) {
        length_minuteKey.currentState!.validate();
      }
    });
    languageFocusNode.addListener(() {
      if (!(languageFocusNode.hasFocus)) {
        languageKey.currentState!.validate();
      }
    });
    publisherFocusNode.addListener(() {
      if (!(publisherFocusNode.hasFocus)) {
        publisherKey.currentState!.validate();
      }
    });
    episodeFocusNode.addListener(() {
      if (!(episodeFocusNode.hasFocus)) {
        episodeKey.currentState!.validate();
      }
    });
    continues_fromFocusNode.addListener(() {
      if (!(continues_fromFocusNode.hasFocus)) {
        continues_fromKey.currentState!.validate();
      }
    });
  }

  @override
  void dispose() {
    parentFocusNode.dispose();
    typeFocusNode.dispose();
    generFocusNode.dispose();
    categoryFocusNode.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    priceFocusNode.dispose();
    authorFocusNode.dispose();
    readerFocusNode.dispose();
    translatorFocusNode.dispose();
    length_minuteFocusNode.dispose();
    length_minuteFocusNode.dispose();
    languageFocusNode.dispose();
    publisherFocusNode.dispose();
    episodeFocusNode.dispose();
    continues_fromFocusNode.dispose();
    first_published_atFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build ,,,,,,,,,,,,,,');
    void _presentDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(10000),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          createMaterialData["first_published_at"] = pickedDate;
        });
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Create Your Material ',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _createChannelformKey,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Parent for Material:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(top: 5, bottom: 8),
                                child: SizedBox(
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.grey[300],
                                    decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      hintText: 'Parent',
                                    ),
                                    value: createMaterialData["parent"],
                                    items: <String>[
                                      'Publication',
                                      'Audio',
                                      'Unspecified',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        createMaterialData["parent"] =
                                            value as String;
                                        print(
                                            "pare......${createMaterialData["parent"]}");
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Type of Material:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(top: 5, bottom: 8),
                                child: SizedBox(
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.grey[300],
                                    decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      hintText: 'type',
                                    ),
                                    value: createMaterialData["type"],
                                    items: createMaterialData["parent"]
                                            .toString()
                                            .contains('Publication')
                                        ? <String>[
                                            "Book",
                                            "Megazin",
                                            "Newspaper",
                                            "Unspecified",
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : <String>[
                                            "Podcast",
                                            "Audiobook",
                                            "Unspecified",
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        createMaterialData["type"] =
                                            value as String;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Material Genere:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.grey[300],
                                    decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      hintText: 'genere',
                                    ),
                                    value: createMaterialData["genere"],
                                    items: <String>[
                                      "Psycology",
                                      "Commedy",
                                      "Unspecified"
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        createMaterialData["genere"] =
                                            value as String;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Material Catagory:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(top: 5, bottom: 8),
                                child: SizedBox(
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.grey[300],
                                    decoration: const InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      hintText: 'Parent',
                                    ),
                                    value: createMaterialData["catagory"],
                                    items: <String>[
                                      "Fiction",
                                      "Story",
                                      "Documentary",
                                      "Unspecified"
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        createMaterialData["catagory"] =
                                            value as String;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    suffixIconColor: Colors.grey,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 7),
                                    filled: true,
                                    fillColor: Colors.white60,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0),
                                    ),
                                    hintText: 'Enter Title',
                                  ),
                                  focusNode: titleFocusNode,
                                  key: titleKey,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Title can\'t be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (newValue) {
                                    createMaterialData["title"] = newValue;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    suffixIconColor: Colors.grey,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 7),
                                    filled: true,
                                    fillColor: Colors.white60,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0),
                                    ),
                                    // focusColor: Colors.grey,
                                    // labelText: 'Full Name',
                                    hintText: 'Enter Price In Birr',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  // controller: _emailController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'price can\'t be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  focusNode: priceFocusNode,
                                  key: priceKey,

                                  onSaved: (newValue) {
                                    createMaterialData["price"] = newValue;
                                  },
                                ),
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
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    // focusColor: Colors.grey,
                                    // labelText: 'Full Name',
                                    hintText: 'I created this channel to...',
                                  ),
                                  // obscureText: true,
                                  controller: null,
                                  focusNode: descriptionFocusNode,
                                  key: descriptionKey,
                                  validator:
                                      SignUpFormHandler.discriptionValidator,
                                  onSaved: (newValue) {
                                    createMaterialData["description"] =
                                        newValue;
                                  },
                                  // validator:
                                ),
                              ),
                              if (createMaterialData['parent'] != 'Audio')
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Author (Optional)',
                                    ),
                                    focusNode: authorFocusNode,
                                    key: authorKey,
                                    onSaved: (newValue) {
                                      createMaterialData["author"] = newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["type"] == "Audiobook")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Reader(Optional)',
                                    ),
                                    focusNode: readerFocusNode,
                                    key: readerKey,
                                    onSaved: (newValue) {
                                      createMaterialData["reader"] = newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["parent"] != "Audio")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Translator of Material',
                                    ),
                                    focusNode: translatorFocusNode,
                                    key: translatorKey,
                                    onSaved: (newValue) {
                                      createMaterialData["translator"] =
                                          newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["parent"] == "Audio")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText:
                                          'Enter Length of Material In Minutes',
                                    ),
                                    focusNode: length_minuteFocusNode,
                                    key: length_minuteKey,
                                    onSaved: (newValue) {
                                      createMaterialData["length_minute"] =
                                          newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["parent"] != "Audio")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Page Length',
                                    ),
                                    focusNode: length_pageFocusNode,
                                    key: length_pageKey,
                                    onSaved: (newValue) {
                                      createMaterialData["length_page"] =
                                          newValue;
                                    },
                                  ),
                                ),
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 7),
                                    filled: true,
                                    fillColor: Colors.white60,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0),
                                    ),
                                    // focusColor: Colors.grey,
                                    // labelText: 'Full Name',
                                    hintText: 'Enter  Material Language',
                                  ),
                                  focusNode: languageFocusNode,
                                  key: languageKey,
                                  onSaved: (newValue) {
                                    createMaterialData["language"] = newValue;
                                  },
                                ),
                              ),
                              if (createMaterialData["parent"] != "Audio")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText:
                                          'Enter Publisher of the Material',
                                    ),
                                    focusNode: publisherFocusNode,
                                    key: publisherKey,
                                    onSaved: (newValue) {
                                      createMaterialData["publisher"] =
                                          newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["type"] == "Podcast")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Episode',
                                    ),
                                    focusNode: episodeFocusNode,
                                    key: episodeKey,
                                    onSaved: (newValue) {
                                      createMaterialData["episode"] = newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["type"] == "Podcast")
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 7),
                                      filled: true,
                                      fillColor: Colors.white60,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0),
                                      ),
                                      // focusColor: Colors.grey,
                                      // labelText: 'Full Name',
                                      hintText: 'Enter Continues From',
                                    ),
                                    focusNode: continues_fromFocusNode,
                                    key: continues_fromKey,
                                    onSaved: (newValue) {
                                      createMaterialData["continues_from"] =
                                          newValue;
                                    },
                                  ),
                                ),
                              if (createMaterialData["parent"] != "Audio")
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: _presentDatePicker,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: createMaterialData[
                                                      "first_published_at"] ==
                                                  0
                                              ? Text(
                                                  'Enter First Publication Date')
                                              : Text(
                                                  ' ${DateFormat.yMd().format(createMaterialData["first_published_at"])}',
                                                ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: _presentDatePicker,
                                          icon: Icon(Icons.date_range))
                                    ],
                                  ),
                                ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A19A),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: double.infinity,

                                  child: MaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    child: isSendingSignUpRequestWithEmail
                                        ? CircularProgressIndicator()
                                        : Text('Continue'),
                                    onPressed: continueCreatingMaterial,
                                  ),
                                  // child: Text('Sign Up'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //sign up method
  void continueCreatingMaterial() async {
    if (!_createChannelformKey.currentState!.validate()) {
      return;
    }

    _createChannelformKey.currentState!.save();
    int? materialId;
    setState(() {
      isSendingSignUpRequestWithEmail = true;
    });
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }

      final futureMId =
          Provider.of<materialCreationProvider>(context, listen: false)
              .CreateMaterial(createMaterialData, token);
      materialId = await futureMId;
      if (materialId == null) {
        throw 'failed to proceed';
      }
    } on HttpException catch (error) {
      print(error);

      showalert('$error');
    } catch (error) {
      showalert('$error');
    }
    setState(() {
      isSendingSignUpRequestWithEmail = false;
    });

    if (materialId != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MaterialUpload(materialId: materialId),
      ));
    }
  }
}
