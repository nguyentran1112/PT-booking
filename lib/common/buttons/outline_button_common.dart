import 'package:flutter/material.dart';

class OutlineButtonCommon extends StatelessWidget {
  const OutlineButtonCommon({super.key, this.onPressed, required this.text, this.style, this.textStyle});
  final VoidCallback? onPressed;
  final String text;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: style ??
            OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              side: const BorderSide(color: Colors.grey),
            ),
        child: Text(text, style: textStyle));
  }
}