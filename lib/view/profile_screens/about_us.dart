import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Amped Media!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'At Amped Media, we are the founders of a revolutionary platform designed to empower content creators and publishers. Our mission is to help you expand your reach and amplify your impact. Through our intuitive mobile app, you can effortlessly share your materials in various formats, including podcasts, magazines, and books. We provide a user-friendly interface that simplifies the process of uploading and publishing your content, ensuring it is presented in the best possible way.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Whether you are an aspiring podcaster, a talented writer Amped Media is here to support you. Our app offers a range of features and tools to help you showcase your unique talents and connect with your target audience.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
