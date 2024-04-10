import 'package:ampedmedia_flutter/view/resetpassword/setnewpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmEmail extends StatefulWidget {
  static final routeName = 'ConfirmEmail';
  const ConfirmEmail({super.key});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirmation',
              style: TextStyle(fontSize: 32),
            ),
            Text(
              'Enter the code that we sent to your email',
              style: TextStyle(fontSize: 12),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20),
              // color: Colors.red,
              height: 108,
              child: Form(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 45,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 0),
                            ),
                            // focusColor: Colors.white,
                            // labelText: 'Full Name',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 45,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 0),
                            ),
                            // focusColor: Colors.white,
                            // labelText: 'Full Name',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 45,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 0),
                            ),
                            // focusColor: Colors.white,
                            // labelText: 'Full Name',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 45,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 0),
                            ),
                            // focusColor: Colors.white,
                            // labelText: 'Full Name',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 45,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 0),
                            ),
                            // focusColor: Colors.white,
                            // labelText: 'Full Name',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 45,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 0),
                            ),
                            // focusColor: Colors.white,
                            // labelText: 'Full Name',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF00A19A),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text('Confirm'),
                  onPressed: () => confirm(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SetNewPassword(),
    ));
  }
}
