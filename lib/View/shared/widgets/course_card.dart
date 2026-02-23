import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Reusable course card widget for displaying course information
class CourseCardWidget extends StatelessWidget {
  const CourseCardWidget({
    super.key,
    required this.imageAddress,
    required this.onTap,
    required this.label,
  });

  final String imageAddress;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: 135,
              margin: const EdgeInsets.only(bottom: 5.0, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageAddress,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Course card data model
class CourseCardData {
  final String imageAddress;
  final String label;
  final VoidCallback? onTap;

  const CourseCardData({
    required this.imageAddress,
    required this.label,
    this.onTap,
  });

  /// Converts this data to a widget
  Widget toWidget() {
    return CourseCardWidget(
      imageAddress: imageAddress,
      label: label,
      onTap: onTap,
    );
  }
}
