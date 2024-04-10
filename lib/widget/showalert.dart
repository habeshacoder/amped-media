import 'package:flutter/material.dart';

class ShowAlert extends StatelessWidget {
  final message;
  const ShowAlert({required this.message});

  @override
  Widget build(BuildContext context) {
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
  }
}
