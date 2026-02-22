
// Function to show Awesome SnackBar
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(
    {required String title, required String message, required Color color}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: color.withOpacity(0.7), // semi-transparent background
    colorText: Colors.white, // text color
    borderRadius: 10, // rounded corners
    margin: const EdgeInsets.all(10), // margin around snackbar
    padding: const EdgeInsets.symmetric(
        horizontal: 20, vertical: 15), // padding inside snackbar
    duration: const Duration(seconds: 3), // how long the snackbar is shown
    isDismissible: true, // can be dismissed
    dismissDirection: DismissDirection.horizontal, // direction of dismissal
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // shadow effect
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}