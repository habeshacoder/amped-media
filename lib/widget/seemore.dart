import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  SeeMoreText({required this.text, required this.maxLength});

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final fullText = TextSpan(
        text: widget.text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: '    see less',
            style: TextStyle(
              color: Color(0xFF00A19A),
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  _isExpanded = false;
                });
              },
          ),
        ]);

    final collapsedText = TextSpan(
      text: widget.text.substring(0, widget.maxLength),
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      children: [
        TextSpan(text: '... '),
        TextSpan(
          text: 'see more',
          style: TextStyle(
            color: Color(0xFF00A19A),
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                _isExpanded = true;
              });
            },
        ),
      ],
    );

    return RichText(
      // overflow: TextOverflow.ellipsis,
      text: _isExpanded ? fullText : collapsedText,
    );
  }
}

class SeeMoreWidget extends StatelessWidget {
  SeeMoreWidget({required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeeMoreText(
          text: description,
          maxLength: description.length > 2 ? 3 : 1,
        ),
      ],
    );
  }
}
