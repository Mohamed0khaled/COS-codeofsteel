/// General Application Constants

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Code of Steel';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyFirstTime = 'first_time';
  static const String keyIsDarkMode = 'isDarkMode';
  static const String keyLangCode = 'langCode';
  static const String keyUsername = 'username';

  // Default Values
  static const String defaultRank = 'E';
  static const int defaultScore = 0;
  static const int defaultLevel = 0;
  static const String defaultPspl = 'C++';
  static const String defaultUsername = 'Guest';

  // Rank Thresholds
  static const Map<String, int> rankThresholds = {
    'E': 0,
    'D': 10,
    'C': 70,
    'B': 150,
    'A': 300,
    'A+': 600,
    'A++': 1000,
    'S': 1500,
  };

  // Quiz Timer Duration
  static const Duration quizDuration = Duration(minutes: 15);

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 1000);
}
