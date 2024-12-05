import 'package:flutter/material.dart';

class OutlineButtonCommon extends StatelessWidget {
  const OutlineButtonCommon({super.key, this.onPressed, required this.text, this.style, this.textStyle});
  final VoidCallback? onPressed;
  final String text;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, style: style, child: Text(text, style: textStyle));
  }
}