import 'package:ampedmedia_flutter/model/materialmodel.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/formhandler/signupformhandler.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/view/detailview/bookdetailview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class WrittingReview extends StatefulWidget {
  WrittingReview({required this.book});
  final MaterialModel book;

  @override
  State<WrittingReview> createState() => WrittingReviewState();
}

class WrittingReviewState extends State<WrittingReview> {
  var isSendingRequest = false;
  double initiakRating = 0;
  int _remainingChars = 100;
  final remarkKey = GlobalKey<FormFieldState>();

  //sign up data for form values
  final Map<String, dynamic> reviewSubmissionData = {
    "rating": 0,
    "remark": "",
    "channel_id": "",
  };

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Rate ${widget.book.title} ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF00A19A),
                borderRadius: BorderRadius.circular(5)),
            height: 20,
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: InkWell(
              onTap: rate,
              child: isSendingRequest
                  ? CircularProgressIndicator()
                  : TextButton.icon(
                      label: Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: null),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(),
                child: Text(
                  'Reviews are public and include your account',
                  style: TextStyle(fontSize: 18),
                )),
            RatingBar.builder(
              initialRating: initiakRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  reviewSubmissionData["rating"] = rating;
                  initiakRating = rating;
                });
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                maxLength: 100,

                minLines: 3,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  // focusColor: Colors.grey,
                  // labelText: 'Full Name',
                  hintText: 'Describe your experience...',
                ),
                // obscureText: true,
                controller: null,
                key: remarkKey,
                validator: SignUpFormHandler.discriptionValidator,
                onSaved: (newValue) {
                  reviewSubmissionData["remark"] = newValue;
                },
                // validator:
              ),
            ),
          ],
        ),
      ),
    );
  }

//save review
  void rate() async {
    if (initiakRating == 0) {
      showalert('please rate the material first');
      return;
    }
    if (!remarkKey.currentState!.validate()) {
      showalert('please rate the material first');
      return;
    }
    remarkKey.currentState!.save();

    if (reviewSubmissionData["remark"] == null ||
        reviewSubmissionData["remark"].toString().isEmpty) {
      showalert('please write your experience');
      return;
    }
    reviewSubmissionData["material_id"] = widget.book.id;
    setState(() {
      isSendingRequest = true;
    });
    print(reviewSubmissionData["material_id"]);
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }

      await Provider.of<materialCreationProvider>(context, listen: false)
          .rateMaterial(token, reviewSubmissionData);
      print('...............');
    } catch (error) {
      showalert('$error');
    }
    setState(() {
      isSendingRequest = false;
    });
    Navigator.of(context).pop(MaterialPageRoute(
      builder: (context) => BookDetailView(book: widget.book),
    ));
  }
}
