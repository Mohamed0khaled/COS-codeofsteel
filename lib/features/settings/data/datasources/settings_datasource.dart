import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/settings_model.dart';

/// Local data source for Settings - handles SharedPreferences operations
abstract class SettingsLocalDataSource {
  /// Get current settings from local storage
  SettingsModel getSettings();

  /// Save dark mode setting
  Future<void> setDarkMode(bool isDarkMode);

  /// Save language setting
  Future<void> setLanguage(String languageCode);

  /// Save programming language setting
  Future<void> setProgrammingLanguage(String language);

  /// Check if first app launch
  Future<bool> isFirstLaunch();

  /// Mark first launch as complete
  Future<void> completeFirstLaunch();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _darkModeKey = 'isDarkMode';
  static const String _languageKey = 'langCode';
  static const String _programmingLanguageKey = 'problem_solving_language';
  static const String _firstLaunchKey = 'first_time';

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  SettingsModel getSettings() {
    final isDarkMode = sharedPreferences.getBool(_darkModeKey) ?? false;
    final languageCode = sharedPreferences.getString(_languageKey) ?? 'en';
    final programmingLanguage = 
        sharedPreferences.getString(_programmingLanguageKey) ?? 'C++';

    return SettingsModel(
      isDarkMode: isDarkMode,
      languageCode: languageCode,
      programmingLanguage: programmingLanguage,
    );
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await sharedPreferences.setBool(_darkModeKey, isDarkMode);
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await sharedPreferences.setString(_languageKey, languageCode);
  }

  @override
  Future<void> setProgrammingLanguage(String language) async {
    await sharedPreferences.setString(_programmingLanguageKey, language);
  }

  @override
  Future<bool> isFirstLaunch() async {
    return sharedPreferences.getBool(_firstLaunchKey) ?? true;
  }

  @override
  Future<void> completeFirstLaunch() async {
    await sharedPreferences.setBool(_firstLaunchKey, false);
  }
}

/// Remote data source for syncing settings to Firestore
abstract class SettingsRemoteDataSource {
  /// Sync programming language to user profile in Firestore
  Future<void> syncProgrammingLanguage(String userId, String language);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseFirestore firestore;

  SettingsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> syncProgrammingLanguage(String userId, String language) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'pspl': language,
      });
    } catch (e) {
      // If document doesn't exist or update fails, silently handle
      // The setting is still saved locally
    }
  }
}
