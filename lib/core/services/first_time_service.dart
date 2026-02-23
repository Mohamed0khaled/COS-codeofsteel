import 'package:shared_preferences/shared_preferences.dart';

/// Service to check if the app is opened for the first time
class FirstTimeService {
  static const String _firstTimeKey = 'first_time';
  
  /// Check if the app is opened for the first time
  /// Returns true if first time, false otherwise
  /// Also marks the app as opened after checking
  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Check if the 'first_time' key exists in SharedPreferences
    bool isFirstTime = prefs.getBool(_firstTimeKey) ?? true;
    
    // If this is the first time, set the value to false for future launches
    if (isFirstTime) {
      await prefs.setBool(_firstTimeKey, false);
    }
    
    return isFirstTime;
  }
  
  /// Reset the first time flag (useful for testing)
  static Future<void> resetFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, true);
  }
}
