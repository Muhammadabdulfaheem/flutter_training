import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(8.0), // Default border radius
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) {
          // Use SizedBox or Container to adjust the size of the progress indicator
          return placeholder ??
              Center(
                child: SizedBox(
                  width: 30.0, // Adjust width to control size
                  height: 30.0, // Adjust height to control size
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5, // Adjust stroke width to control the size
                  ),
                ),
              );
        },
        errorWidget: (context, url, error) {
          return errorWidget ?? Icon(Icons.error); // Default error widget
        },
      ),
    );
  }
}
