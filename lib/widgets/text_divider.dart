import 'package:flutter/material.dart';
import 'package:minesweeper/support/theme.dart';

// Divider with text in the middle
class TextDivider extends StatelessWidget {
  final String text;
  const TextDivider({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: accentColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(color: accentColor),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: accentColor,
          ),
        ),
      ],
    );
  }
}
