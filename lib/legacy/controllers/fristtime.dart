import 'package:shared_preferences/shared_preferences.dart';

class AppOpenChecker {
  // Function to check if the app is opened for the first time
  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the 'first_time' key exists in SharedPreferences
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    // If this is the first time, set the value to false for future launches
    if (isFirstTime) {
      await prefs.setBool('first_time', false);
    }

    return isFirstTime;
  }
}
