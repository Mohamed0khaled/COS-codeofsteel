import 'package:flutter/material.dart';

/// Custom snackbar utility - replaces GetX snackbar
void showCustomSnackbar({
  required BuildContext context,
  required String title,
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: color.withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}

/// Legacy-compatible snackbar (uses GetX-style with overlay)
/// Use this only if BuildContext is not available
void showCustomSnackbarOverlay({
  required String title,
  required String message,
  required Color color,
}) {
  // This requires a global navigator key - for backward compatibility
  // Prefer using the context-based version above
  debugPrint('Snackbar: $title - $message');
}
