import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LangController extends GetxController {
  var isArabic = false.obs;
  final GetStorage _storage = GetStorage(); // Initialize GetStorage instance

  @override
  void onInit() {
    super.onInit();
    // Load the saved language setting from storage
    String? savedLang = _storage.read<String>('langCode');
    if (savedLang != null) {
      ChangeLang(savedLang);
    }
  }

  void ChangeLang(String langCode) {
    if (langCode == 'ar') {
      isArabic.value = true;
    } else {
      isArabic.value = false;
    }
    _storage.write('langCode', langCode); // Save the language to storage
    Get.updateLocale(Locale(langCode));
  }
}
