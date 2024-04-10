import 'package:flutter/material.dart';

class SplashSCreen extends StatelessWidget {
  const SplashSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(child: Container(
        child: Text('please wait...'))),
    ));
  }
}
