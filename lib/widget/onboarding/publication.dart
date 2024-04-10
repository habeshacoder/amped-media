import 'package:ampedmedia_flutter/provider/onboadingprovider.dart';
import 'package:flutter/material.dart';

class publication extends StatelessWidget {
  const publication({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 450,
      child: Column(
        children: [
          Container(
            child: Image(
              width: double.infinity,
              image: AssetImage(onboardingProvider[0].image),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 9),
            child: Text(
              onboardingProvider[0].title,
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Lora',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6, left: 9),
            child: Text(
              onboardingProvider[0].discription,
              style: TextStyle(
                fontFamily: 'Open',
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
