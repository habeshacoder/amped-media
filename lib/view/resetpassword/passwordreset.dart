import 'package:ampedmedia_flutter/view/resetpassword/confirmemail.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
              'Reset Password',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Have you forgotten your password? We will send the confirmation code to your email address.',
              style: TextStyle(fontSize: 12),
              softWrap: true,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      maxLines: 1,

                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.person),
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
                        hintText: 'E-Mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      // validator:
                      onSaved: null,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 29),
                decoration: BoxDecoration(
                  color: Color(0xFF00A19A),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text('Reset'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConfirmEmail(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
