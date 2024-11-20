import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxWords;

  const ExpandableText({
    Key? key,
    required this.text,
    this.maxWords = 20, 
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final words = widget.text.split(" ");
    final isLongText = words.length > widget.maxWords;

    String displayText = isLongText && !isExpanded
        ? words.sublist(0, widget.maxWords).join(" ") + "..."
        : widget.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: displayText,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            children: [
              if (isLongText)
                TextSpan(
                  text: isExpanded ? " Tampilkan lebih sedikit" : " Selengkapnya",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
