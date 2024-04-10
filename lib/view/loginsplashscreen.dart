import 'package:flutter/material.dart';

class LogInSplashScreen extends StatelessWidget {
  const LogInSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color(0xFF00A19A),
        child: Center(
          child: Container(
            child: CircularProgressIndicator(color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
