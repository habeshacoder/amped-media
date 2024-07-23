import 'package:ampedmedia_flutter/provider/buy_provider.dart';
import 'package:ampedmedia_flutter/view/payment/chapa_checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth.dart';

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  bool isSubmitingForm = false;
  final _formKey = GlobalKey<FormState>();

  String _firstName = 'abc';
  String _lastName = 'def';
  String _email = 'abcdef@gmail.com';
  String _phoneNo = '0912345678';
  String _currency = 'ETB';
  List<int> _material = [];
  double _price = 260.0;
  double _tax = 0.0;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _tax = _price * 0.05;
    _total = _price + _tax;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showBottomModalSheet,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFF00A19A), borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('buy now'),
      ),
    );
  }

  _showBottomModalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: _firstName,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'First Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _firstName = value!;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _lastName,
                      // decoration: InputDecoration(
                      //   labelText: 'Last Name',
                      // ),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Last Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _lastName = value!;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _phoneNo,
                      // decoration: InputDecoration(
                      //   labelText: 'Phone Number',
                      // ),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Phone Number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNo = value!;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _currency,
                      // decoration: InputDecoration(
                      //   labelText: 'Currency',
                      // ),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Currency',
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _price.toString(),
                      // decoration: InputDecoration(
                      //   labelText: 'Price',
                      // ),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Price',
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _tax.toString(),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Tax',
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: _total.toString(),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
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
                        labelText: 'Total',
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF00A19A),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text('Buy Now'),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print('/////////////////////////invalid form');
                            return;
                          }
                          print('/////////////////////////');
                          final Map<String, dynamic> paymentData = {
                            "first_name": _firstName,
                            "last_name": _lastName,
                            "email": _email,
                            "phone_no": _phoneNo,
                            "currency": _currency,
                            "price": _price,
                            "tax": _tax,
                            "total": _total,
                            "material": [0],
                          };
                          sendPaymentData(paymentData);
                        },
                      ),
                      // child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void sendPaymentData(Map<String, dynamic> paymentData) async {
    dynamic checkout_Url;
    final token = Provider.of<Auth>(context, listen: false).token;
    if (token == null) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unautherized'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    try {
      checkout_Url = await Provider.of<BuyProvider>(context, listen: false)
          .sendPayment(token, paymentData);
      ;
      print(checkout_Url);
      Navigator.of(context).pop();
      //add webview here
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChapaCheckoutPage(
            checkoutUrl: checkout_Url,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('you have successfully send payment:$checkout_Url'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
