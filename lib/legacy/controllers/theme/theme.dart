import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final GetStorage _storage = GetStorage(); // Initialize GetStorage instance

  @override
  void onInit() {
    super.onInit();
    // Load the saved theme mode setting from storage
    bool? savedThemeMode = _storage.read<bool>('isDarkMode');
    if (savedThemeMode != null) {
      isDarkMode.value = savedThemeMode;
    }
  }

  ThemeData get themeData => isDarkMode.value ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write('isDarkMode', isDarkMode.value); // Save the theme mode to storage
  }
}
