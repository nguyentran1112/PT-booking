import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageNetworkCacheCommon extends StatelessWidget {
  const ImageNetworkCacheCommon({super.key, required this.imageUrl, this.placeholder, this.errorWidget, this.width, this.height, this.fit});
  final String imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => placeholder ?? _buildPlaceholder(),
        errorWidget: (context, url, error) => errorWidget ?? const Icon(Icons.error),
        width: width,
        height: height,
        fit: fit);
  }

  Widget _buildPlaceholder() {
    return Skeletonizer(
        child: Container(
      width: width,
      height: height,
      color: Colors.transparent,
    ));
  }
}