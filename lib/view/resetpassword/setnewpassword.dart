import 'package:ampedmedia_flutter/dashboard.dart';
import 'package:flutter/material.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
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
            Text('Reset Password.'),
            Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
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
                          borderSide: BorderSide(color: Colors.black, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0),
                        ),
                        // focusColor: Colors.grey,
                        // labelText: 'Full Name',
                        hintText: 'New Password',
                      ),
                      obscureText: true,
                      controller: null,
                      // validator:
                      onSaved: null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
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
                          borderSide: BorderSide(color: Colors.black, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0),
                        ),
                        // focusColor: Colors.grey,
                        // labelText: 'Full Name',
                        hintText: 'Confirm Password',
                      ),
                      obscureText: true,
                      controller: null,
                      // validator:
                      onSaved: null,
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF00A19A),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text('Confirm Change'),
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
            )
          ],
        ),
      ),
    );
  }
}
