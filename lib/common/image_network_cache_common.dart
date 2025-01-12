import 'dart:convert';

import 'package:flutter/material.dart';

class ImageNetworkCacheCommon extends StatelessWidget {
  const ImageNetworkCacheCommon(
      {super.key,
      required this.base64,
      this.errorWidget,
      this.width,
      this.height,
      this.fit});
  final String base64;

  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image.memory(base64Decode(base64),
        errorBuilder: (context, error, stackTrace) {
      return errorWidget ??
          const Icon(Icons.error, size: 50, color: Colors.red);
    }, width: width, height: height, fit: fit);
  }
}
