import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordUpdateForm extends StatefulWidget {
  @override
  _PasswordUpdateFormState createState() => _PasswordUpdateFormState();
}

class _PasswordUpdateFormState extends State<PasswordUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _ConfirmNewPasswordController = TextEditingController();
  bool isSendingRequest = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Perform the password update logic here
      _formKey.currentState!.save();
      String oldPassword = _oldPasswordController.text;
      String newPassword = _newPasswordController.text;
      String ConfirmNewPassword = _ConfirmNewPasswordController.text;
      Map<String, dynamic> passData = {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "newPasswordConfirm": ConfirmNewPassword,
      };
      setState(() {
        isSendingRequest = true;
      });
      try {
        int statusCode = await Provider.of<Auth>(context, listen: false)
            .updatePassword(passData: passData);
        setState(() {
          isSendingRequest = false;
        });
        if (statusCode == 200 || statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('password updated.'),
            ),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text('Failed to update the password.'),
            ),
          );
        }
      } catch (e) {
        setState(() {
          isSendingRequest = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text('Failed to update the password.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Old Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _ConfirmNewPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (_ConfirmNewPasswordController.text !=
                        _newPasswordController.text) {
                      return 'password mismatch';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF00A19A),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: double.infinity,

                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: isSendingRequest
                          ? CircularProgressIndicator()
                          : Text('Update Password'),
                      onPressed: _submitForm,
                    ),
                    // child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
